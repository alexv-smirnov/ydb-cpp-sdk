#include <ydb/library/yql/minikql/computation/mkql_computation_node_impl.h>
#include <ydb/library/yql/minikql/computation/mkql_computation_node_holders.h>
#include <ydb/library/yql/minikql/invoke_builtins/mkql_builtins.h>
#include <ydb/library/yql/minikql/mkql_node_cast.h>
#include <ydb/library/yql/minikql/mkql_node.h>
#include <ydb/library/yql/minikql/mkql_program_builder.h>
#include <ydb/library/yql/minikql/mkql_string_util.h>

#include "mkql_computation_node_ut.h" 

#include <random> 
#include <ctime> 
#include <algorithm> 
 
namespace NKikimr {
namespace NMiniKQL {

namespace {

template <bool LLVM> 
TRuntimeNode MakeStream(TSetup<LLVM>& setup) { 
    TProgramBuilder& pgmBuilder = *setup.PgmBuilder;

    TCallableBuilder callableBuilder(*setup.Env, "TestYieldStream", 
        pgmBuilder.NewStreamType(
            pgmBuilder.NewStructType({
                {TStringBuf("a"), pgmBuilder.NewDataType(NUdf::EDataSlot::Uint64)},
                {TStringBuf("b"), pgmBuilder.NewDataType(NUdf::EDataSlot::String)}
            })
        )
    );

    return TRuntimeNode(callableBuilder.Build(), false);
}

TRuntimeNode StreamToString(TProgramBuilder& pgmBuilder, TRuntimeNode stream) { 
    return pgmBuilder.Condense(stream, 
        pgmBuilder.NewDataLiteral<NUdf::EDataSlot::String>("|"),
            [&] (TRuntimeNode, TRuntimeNode) { return pgmBuilder.NewDataLiteral<bool>(false); }, 
            [&] (TRuntimeNode item, TRuntimeNode state) {
                auto str = pgmBuilder.Concat(
                    pgmBuilder.Concat(
                        pgmBuilder.ToString(pgmBuilder.Member(item, "a")),
                        pgmBuilder.NewDataLiteral<NUdf::EDataSlot::String>("-")
                    ),
                    pgmBuilder.Member(item, "b")
                );

                return pgmBuilder.Concat(pgmBuilder.Concat(state, str),
                    pgmBuilder.NewDataLiteral<NUdf::EDataSlot::String>("|"));
            } 
        ); 
}

} // namespace

Y_UNIT_TEST_SUITE(TMiniKQLSortTest) {
    Y_UNIT_TEST_LLVM(TestStreamSort) { 
        TSetup<LLVM> setup; 
        TProgramBuilder& pgmBuilder = *setup.PgmBuilder;

        auto stream = MakeStream(setup);
        std::vector<TRuntimeNode> order { 
            pgmBuilder.NewDataLiteral<bool>(true),
            pgmBuilder.NewDataLiteral<bool>(false)
        };
        auto sort = pgmBuilder.Sort(stream, pgmBuilder.NewTuple(order),
            [&pgmBuilder](TRuntimeNode item) {
                std::vector<TRuntimeNode> keys { 
                    pgmBuilder.Member(item, "a"),
                    pgmBuilder.Member(item, "b")
                };

                return pgmBuilder.NewTuple(keys);
            });

        auto pgmResult = StreamToString(pgmBuilder, sort); 

        auto graph = setup.BuildGraph(pgmResult);
        auto value = graph->GetValue();


        NUdf::TUnboxedValue result;
        auto yieldCount = 0U; 
        auto status = NUdf::EFetchStatus::Ok;
        while (status != NUdf::EFetchStatus::Finish) {
            status = value.Fetch(result);
            if (status == NUdf::EFetchStatus::Yield) {
                ++yieldCount;
            }
        }

        UNIT_ASSERT_EQUAL(status, NUdf::EFetchStatus::Finish);
        UNIT_ASSERT_EQUAL(yieldCount, 3U); 
        UNIT_ASSERT_VALUES_EQUAL(TStringBuf(result.AsStringRef()),
            "|0-8|0-4|0-11|0-0|1-9|1-6|1-13|1-1|2-7|2-2|2-14|2-10|");
    }
 
    Y_UNIT_TEST_LLVM(TestFlowSortByLambdaComparator) { 
        TSetup<LLVM> setup; 
        TProgramBuilder& pgmBuilder = *setup.PgmBuilder; 
 
        const auto stream = MakeStream(setup); 
 
        const auto sort = 
            pgmBuilder.FromFlow(pgmBuilder.FlatMap( 
                pgmBuilder.Condense1(pgmBuilder.ToFlow(stream), 
                    [&](TRuntimeNode item) { return pgmBuilder.AsList(item); }, 
                    [&](TRuntimeNode, TRuntimeNode) { return pgmBuilder.NewDataLiteral<bool>(false); }, 
                    [&](TRuntimeNode item, TRuntimeNode state) { return pgmBuilder.Append(state, item); } 
                ), 
                [&](TRuntimeNode list) { 
                    return pgmBuilder.StableSort(list, 
                        [&](TRuntimeNode left, TRuntimeNode right) { 
                            return pgmBuilder.Or({ 
                                pgmBuilder.AggrLess(pgmBuilder.Member(left, "a"), pgmBuilder.Member(right, "a")), 
                                pgmBuilder.And({ 
                                    pgmBuilder.AggrEquals(pgmBuilder.Member(left, "a"), pgmBuilder.Member(right, "a")), 
                                    pgmBuilder.AggrGreater(pgmBuilder.Member(left, "b"), pgmBuilder.Member(right, "b")) 
                                }) 
                            }); 
                        } 
                    ); 
                } 
            )); 
 
        const auto pgmResult = StreamToString(pgmBuilder, sort); 
 
        const auto graph = setup.BuildGraph(pgmResult); 
        const auto value = graph->GetValue(); 
 
 
        NUdf::TUnboxedValue result; 
        auto yieldCount = 0U; 
        auto status = NUdf::EFetchStatus::Ok; 
        while (status != NUdf::EFetchStatus::Finish) { 
            status = value.Fetch(result); 
            if (status == NUdf::EFetchStatus::Yield) { 
                ++yieldCount; 
            } 
        } 
 
        UNIT_ASSERT_EQUAL(status, NUdf::EFetchStatus::Finish); 
        UNIT_ASSERT_EQUAL(yieldCount, 3U); 
        UNIT_ASSERT_VALUES_EQUAL(TStringBuf(result.AsStringRef()), 
            "|0-8|0-4|0-11|0-0|1-9|1-6|1-13|1-1|2-7|2-2|2-14|2-10|"); 
    } 
 
    Y_UNIT_TEST_LLVM(TestListSort) { 
        const std::array<double, 10U> xxx = {{9E9, -HUGE_VAL, 0.003, HUGE_VAL, +3.1415, -0.003, -7898.8, -3.1415, 3673.0, 0.003}}; 
 
        TSetup<LLVM> setup; 
        TProgramBuilder& pgmBuilder = *setup.PgmBuilder; 
 
        std::array<TRuntimeNode, 10U> data; 
        std::transform(xxx.cbegin(), xxx.cend(), data.begin(), 
            std::bind(&TProgramBuilder::NewDataLiteral<double>, std::ref(pgmBuilder), std::placeholders::_1 )); 
 
        const auto type = pgmBuilder.NewDataType(NUdf::TDataType<double>::Id); 
        const auto list = pgmBuilder.NewList(type, data); 
 
        const auto pgmReturn = pgmBuilder.Sort(list, pgmBuilder.NewDataLiteral<bool>(false), 
            std::bind(&TProgramBuilder::Abs, std::ref(pgmBuilder), std::placeholders::_1 )); 
 
        const auto graph = setup.BuildGraph(pgmReturn); 
        const auto& result = graph->GetValue(); 
 
        UNIT_ASSERT_VALUES_EQUAL(result.GetListLength(), xxx.size()); 
 
        auto copy = xxx; 
        std::stable_sort(copy.begin(), copy.end(), [](double l, double r){ return std::abs(l) > std::abs(r); }); 
 
        for (auto i = 0U; i < copy.size(); ++i) { 
            UNIT_ASSERT_VALUES_EQUAL(copy[i], result.GetElement(i).template Get<double>()); 
        } 
    } 
 
    Y_UNIT_TEST_LLVM(TestListTop) { 
        TSetup<LLVM> setup; 
 
        std::default_random_engine eng; 
        eng.seed(std::time(nullptr)); 
 
        std::uniform_real_distribution<double> unifd(-999.0, +999.0); 
        std::uniform_real_distribution<ui64> unifi; 
 
        constexpr ui64 total = 999ULL; 
 
        std::array<TRuntimeNode, total> data; 
        std::vector<std::pair<double, ui64>> test; 
        test.reserve(total); 
 
        TProgramBuilder& pgmBuilder = *setup.PgmBuilder; 
 
        std::generate_n(std::back_inserter(test), total, [&]() { return std::make_pair(unifd(eng), unifi(eng) % 100U);}); 
 
        std::transform(test.cbegin(), test.cend(), data.begin(), [&](const auto& pair) { 
            return pgmBuilder.NewTuple({pgmBuilder.NewDataLiteral<double>(pair.first), pgmBuilder.NewDataLiteral<ui64>(pair.second)}); 
        }); 
 
        const auto tupleType = pgmBuilder.NewTupleType({pgmBuilder.NewDataType(NUdf::TDataType<double>::Id), pgmBuilder.NewDataType(NUdf::TDataType<ui64>::Id)}); 
        const auto order = pgmBuilder.NewTuple({pgmBuilder.NewDataLiteral<bool>(false), pgmBuilder.NewDataLiteral<bool>(true)}); 
        const auto list = pgmBuilder.NewList(tupleType, data); 
        const auto extractor = [&pgmBuilder](TRuntimeNode item) { return pgmBuilder.NewTuple({pgmBuilder.Nth(item, 1U), pgmBuilder.Abs(pgmBuilder.Nth(item, 0U))}); }; 
        const auto n = 17ULL; 
        const auto limit = pgmBuilder.NewDataLiteral<ui64>(n); 
 
        const auto pgmReturn = pgmBuilder.Top(list, limit, order, extractor); 
 
        const auto graph = setup.BuildGraph(pgmReturn); 
        const auto& value = graph->GetValue(); 
        UNIT_ASSERT_VALUES_EQUAL(value.GetListLength(), n); 
 
        const auto& iter = value.GetListIterator(); 
 
        auto copy = test; 
 
        const auto comp = [](const auto& l, const auto& r){ return l.second > r.second || (l.second == r.second && std::abs(l.first) < std::abs(r.first)); }; 
        std::nth_element(copy.begin(), copy.begin() + n - 1ULL, copy.end(), comp); 
        copy.resize(n); 
 
        std::vector<std::pair<double, ui64>> res; 
        res.reserve(n); 
 
        for (NUdf::TUnboxedValue item; iter.Next(item);) { 
            res.emplace_back(item.GetElement(0U).template Get<double>(), item.GetElement(1U).template Get<ui64>()); 
        } 
 
        std::sort(copy.begin(), copy.end()); 
        std::sort(res.begin(), res.end()); 
        UNIT_ASSERT(copy == res); 
    } 
 
    Y_UNIT_TEST_LLVM(TestStreamZeroTop) { 
        TSetup<LLVM> setup; 
 
        constexpr ui64 total = 9ULL; 
 
        std::array<TRuntimeNode, total> data; 
 
        TProgramBuilder& pgmBuilder = *setup.PgmBuilder; 
 
        std::generate_n(data.begin(), total, [&]() { 
            return pgmBuilder.NewTuple({pgmBuilder.NewDataLiteral<ui64>(42ULL)}); 
        }); 
 
        const auto tupleType = pgmBuilder.NewTupleType({pgmBuilder.NewDataType(NUdf::TDataType<ui64>::Id)}); 
        const auto order = pgmBuilder.NewTuple({pgmBuilder.NewDataLiteral<bool>(false)}); 
        const auto list = pgmBuilder.NewList(tupleType, data); 
        const auto extractor = [&pgmBuilder](TRuntimeNode item) { return pgmBuilder.NewTuple({pgmBuilder.Nth(item, 0U)}); }; 
        const auto limit = pgmBuilder.NewDataLiteral<ui64>(0ULL); 
 
        const auto pgmReturn = pgmBuilder.Top(pgmBuilder.Iterator(list, {}), limit, order, extractor); 
 
        const auto graph = setup.BuildGraph(pgmReturn); 
        const auto& value = graph->GetValue(); 
        NUdf::TUnboxedValue stub; 
        UNIT_ASSERT_VALUES_EQUAL(value.Fetch(stub), NUdf::EFetchStatus::Finish); 
    } 
 
    Y_UNIT_TEST_LLVM(TestListTopSort) { 
        TSetup<LLVM> setup; 
 
        std::default_random_engine eng; 
        eng.seed(std::time(nullptr)); 
 
        std::uniform_real_distribution<double> unifd(-999.0, +999.0); 
        std::uniform_real_distribution<ui64> unifi; 
 
        constexpr ui64 total = 999ULL; 
 
        std::array<TRuntimeNode, total> data; 
        std::vector<std::pair<double, ui64>> test; 
        test.reserve(total); 
 
        TProgramBuilder& pgmBuilder = *setup.PgmBuilder; 
 
        std::generate_n(std::back_inserter(test), total, [&]() { return std::make_pair(unifd(eng), unifi(eng) % 100U);}); 
 
        std::transform(test.cbegin(), test.cend(), data.begin(), [&](const auto& pair) { 
            return pgmBuilder.NewTuple({pgmBuilder.NewDataLiteral<double>(pair.first), pgmBuilder.NewDataLiteral<ui64>(pair.second)}); 
        }); 
 
        const auto tupleType = pgmBuilder.NewTupleType({pgmBuilder.NewDataType(NUdf::TDataType<double>::Id), pgmBuilder.NewDataType(NUdf::TDataType<ui64>::Id)}); 
        const auto order = pgmBuilder.NewTuple({pgmBuilder.NewDataLiteral<bool>(false), pgmBuilder.NewDataLiteral<bool>(true)}); 
        const auto list = pgmBuilder.NewList(tupleType, data); 
        const auto extractor = [&pgmBuilder](TRuntimeNode item) { return pgmBuilder.NewTuple({pgmBuilder.Nth(item, 1U), pgmBuilder.Abs(pgmBuilder.Nth(item, 0U))}); }; 
        const auto n = 17ULL; 
        const auto limit = pgmBuilder.NewDataLiteral<ui64>(n); 
 
        const auto pgmReturn = pgmBuilder.TopSort(list, limit, order, extractor); 
 
        const auto graph = setup.BuildGraph(pgmReturn); 
        const auto& value = graph->GetValue(); 
        UNIT_ASSERT_VALUES_EQUAL(value.GetListLength(), n); 
 
        const auto& iter = value.GetListIterator(); 
 
        auto copy = test; 
 
        const auto comp = [](const auto& l, const auto& r){ return l.second > r.second || (l.second == r.second && std::abs(l.first) < std::abs(r.first)); }; 
        std::partial_sort(copy.begin(), copy.begin() + n, copy.end(), comp); 
        copy.resize(n); 
 
        std::vector<std::pair<double, ui64>> res; 
        res.reserve(n); 
 
        for (NUdf::TUnboxedValue item; iter.Next(item);) { 
            res.emplace_back(item.GetElement(0U).template Get<double>(), item.GetElement(1U).template Get<ui64>()); 
        } 
 
        UNIT_ASSERT(copy == res); 
    } 
 
    Y_UNIT_TEST_LLVM(TestStreamTop) { 
        TSetup<LLVM> setup; 
 
        std::default_random_engine eng; 
        eng.seed(std::time(nullptr)); 
 
        std::uniform_real_distribution<double> unifd(-999.0, +999.0); 
        std::uniform_real_distribution<ui64> unifi; 
 
        constexpr ui64 total = 999ULL; 
 
        std::array<TRuntimeNode, total> data; 
        std::vector<std::pair<double, ui64>> test; 
        test.reserve(total); 
 
        TProgramBuilder& pgmBuilder = *setup.PgmBuilder; 
 
        std::generate_n(std::back_inserter(test), total, [&]() { return std::make_pair(unifd(eng), unifi(eng) % 100U);}); 
 
        std::transform(test.cbegin(), test.cend(), data.begin(), [&](const auto& pair) { 
            return pgmBuilder.NewTuple({pgmBuilder.NewDataLiteral<double>(pair.first), pgmBuilder.NewDataLiteral<ui64>(pair.second)}); 
        }); 
 
        const auto tupleType = pgmBuilder.NewTupleType({pgmBuilder.NewDataType(NUdf::TDataType<double>::Id), pgmBuilder.NewDataType(NUdf::TDataType<ui64>::Id)}); 
        const auto order = pgmBuilder.NewTuple({pgmBuilder.NewDataLiteral<bool>(true), pgmBuilder.NewDataLiteral<bool>(false)}); 
        const auto list = pgmBuilder.NewList(tupleType, data); 
        const auto extractor = [&pgmBuilder](TRuntimeNode item) { return pgmBuilder.NewTuple({pgmBuilder.Nth(item, 1U), pgmBuilder.Abs(pgmBuilder.Nth(item, 0U))}); }; 
        const auto n = 17ULL; 
        const auto limit = pgmBuilder.NewDataLiteral<ui64>(n); 
 
        const auto pgmReturn = pgmBuilder.Top(pgmBuilder.Iterator(list, {}), limit, order, extractor); 
 
        const auto graph = setup.BuildGraph(pgmReturn); 
        const auto& value = graph->GetValue(); 
 
        auto copy = test; 
 
        const auto comp = [](const auto& l, const auto& r){ return l.second < r.second || (l.second == r.second && std::abs(l.first) > std::abs(r.first)); }; 
        std::nth_element(copy.begin(), copy.begin() + n - 1ULL, copy.end(), comp); 
        copy.resize(n); 
 
        std::vector<std::pair<double, ui64>> res; 
        res.reserve(n); 
 
        for (NUdf::TUnboxedValue item; NUdf::EFetchStatus::Ok == value.Fetch(item);) { 
            res.emplace_back(item.GetElement(0U).template Get<double>(), item.GetElement(1U).template Get<ui64>()); 
        } 
 
        UNIT_ASSERT_VALUES_EQUAL(res.size(), n); 
 
        std::sort(copy.begin(), copy.end()); 
        std::sort(res.begin(), res.end()); 
        UNIT_ASSERT(copy == res); 
    } 
 
    Y_UNIT_TEST_LLVM(TestStreamTopSort) { 
        TSetup<LLVM> setup; 
 
        std::default_random_engine eng; 
        eng.seed(std::time(nullptr)); 
 
        std::uniform_real_distribution<double> unifd(-999.0, +999.0); 
        std::uniform_real_distribution<ui64> unifi; 
 
        constexpr ui64 total = 999ULL; 
 
        std::array<TRuntimeNode, total> data; 
        std::vector<std::pair<double, ui64>> test; 
        test.reserve(total); 
 
        TProgramBuilder& pgmBuilder = *setup.PgmBuilder; 
 
        std::generate_n(std::back_inserter(test), total, [&]() { return std::make_pair(unifd(eng), unifi(eng) % 100U);}); 
 
        std::transform(test.cbegin(), test.cend(), data.begin(), [&](const auto& pair) { 
            return pgmBuilder.NewTuple({pgmBuilder.NewDataLiteral<double>(pair.first), pgmBuilder.NewDataLiteral<ui64>(pair.second)}); 
        }); 
 
        const auto tupleType = pgmBuilder.NewTupleType({pgmBuilder.NewDataType(NUdf::TDataType<double>::Id), pgmBuilder.NewDataType(NUdf::TDataType<ui64>::Id)}); 
        const auto order = pgmBuilder.NewTuple({pgmBuilder.NewDataLiteral<bool>(true), pgmBuilder.NewDataLiteral<bool>(false)}); 
        const auto list = pgmBuilder.NewList(tupleType, data); 
        const auto extractor = [&pgmBuilder](TRuntimeNode item) { return pgmBuilder.NewTuple({pgmBuilder.Nth(item, 1U), pgmBuilder.Abs(pgmBuilder.Nth(item, 0U))}); }; 
        const auto n = 17ULL; 
        const auto limit = pgmBuilder.NewDataLiteral<ui64>(n); 
 
        const auto pgmReturn = pgmBuilder.TopSort(pgmBuilder.Iterator(list, {}), limit, order, extractor); 
 
        const auto graph = setup.BuildGraph(pgmReturn); 
        const auto& value = graph->GetValue(); 
 
        auto copy = test; 
 
        const auto comp = [](const auto& l, const auto& r){ return l.second < r.second || (l.second == r.second && std::abs(l.first) > std::abs(r.first)); }; 
        std::partial_sort(copy.begin(), copy.begin() + n, copy.end(), comp); 
        copy.resize(n); 
 
        std::vector<std::pair<double, ui64>> res; 
        res.reserve(n); 
 
        for (NUdf::TUnboxedValue item; NUdf::EFetchStatus::Ok == value.Fetch(item);) { 
            res.emplace_back(item.GetElement(0U).template Get<double>(), item.GetElement(1U).template Get<ui64>()); 
        } 
 
        UNIT_ASSERT_VALUES_EQUAL(res.size(), n); 
        UNIT_ASSERT(copy == res); 
    } 
 
    Y_UNIT_TEST_LLVM(TestStreamTopSortBySingleField) { 
        TSetup<LLVM> setup; 
 
        std::default_random_engine eng; 
        eng.seed(std::time(nullptr)); 
 
        std::uniform_real_distribution<ui64> unifi; 
 
        constexpr ui64 total = 999ULL; 
 
        std::array<TRuntimeNode, total> data; 
        std::vector<ui64> test; 
        test.reserve(total); 
 
        TProgramBuilder& pgmBuilder = *setup.PgmBuilder; 
 
        std::generate_n(std::back_inserter(test), total, [&]() { return unifi(eng) % 100ULL; }); 
 
        std::transform(test.cbegin(), test.cend(), data.begin(), [&](const ui64& v) { 
            return pgmBuilder.NewTuple({pgmBuilder.NewDataLiteral<ui64>(v)}); 
        }); 
 
        const auto tupleType = pgmBuilder.NewTupleType({pgmBuilder.NewDataType(NUdf::TDataType<ui64>::Id)}); 
        const auto order = pgmBuilder.NewTuple({pgmBuilder.NewDataLiteral<bool>(false)}); 
        const auto list = pgmBuilder.NewList(tupleType, data); 
        const auto extractor = [&pgmBuilder](TRuntimeNode item) { return pgmBuilder.NewTuple({pgmBuilder.Nth(item, 0U)}); }; 
        const auto n = 17ULL; 
        const auto limit = pgmBuilder.NewDataLiteral<ui64>(n); 
 
        const auto pgmReturn = pgmBuilder.TopSort(pgmBuilder.Iterator(list, {}), limit, order, extractor); 
 
        const auto graph = setup.BuildGraph(pgmReturn); 
        const auto& value = graph->GetValue(); 
 
        auto copy = test; 
 
        std::partial_sort(copy.begin(), copy.begin() + n, copy.end(),  std::greater<ui64>()); 
        copy.resize(n); 
 
        std::vector<ui64> res; 
        res.reserve(n); 
 
        for (NUdf::TUnboxedValue item; NUdf::EFetchStatus::Ok == value.Fetch(item);) { 
            res.emplace_back(item.GetElement(0U).template Get<ui64>()); 
        } 
 
        UNIT_ASSERT_VALUES_EQUAL(res.size(), n); 
        UNIT_ASSERT(copy == res); 
    } 
 
    Y_UNIT_TEST_LLVM(TestFlowTopSortWithoutKey) { 
        TSetup<LLVM> setup; 
 
        std::default_random_engine eng; 
        eng.seed(std::time(nullptr)); 
 
        std::uniform_real_distribution<ui64> unifi; 
 
        constexpr ui64 total = 99ULL; 
 
        std::array<TRuntimeNode, total> data; 
        std::vector<ui64> test; 
        test.reserve(total); 
 
        TProgramBuilder& pgmBuilder = *setup.PgmBuilder; 
 
        std::generate_n(std::back_inserter(test), total, [&]() { return unifi(eng) % 100ULL; }); 
 
        std::transform(test.cbegin(), test.cend(), data.begin(), [&](const ui64& v) { 
            return pgmBuilder.NewTuple({pgmBuilder.NewDataLiteral<ui64>(v)}); 
        }); 
 
        const auto tupleType = pgmBuilder.NewTupleType({pgmBuilder.NewDataType(NUdf::TDataType<ui64>::Id)}); 
        const auto order = pgmBuilder.NewTuple({}); 
        const auto list = pgmBuilder.NewList(tupleType, data); 
        const auto extractor = [&pgmBuilder](TRuntimeNode) { return pgmBuilder.NewTuple({}); }; 
        const auto n = 17ULL; 
        const auto limit = pgmBuilder.NewDataLiteral<ui64>(n); 
 
        const auto pgmReturn = pgmBuilder.FromFlow(pgmBuilder.TopSort(pgmBuilder.ToFlow(list), limit, order, extractor)); 
 
        const auto graph = setup.BuildGraph(pgmReturn); 
        const auto& value = graph->GetValue(); 
 
        auto copy = test; 
        copy.resize(n); 
 
        std::vector<ui64> res; 
        res.reserve(n); 
 
        for (NUdf::TUnboxedValue item; NUdf::EFetchStatus::Ok == value.Fetch(item);) { 
            res.emplace_back(item.GetElement(0U).template Get<ui64>()); 
        } 
 
        UNIT_ASSERT_VALUES_EQUAL(res.size(), n); 
        UNIT_ASSERT(copy == res); 
    } 
}
} // NMiniKQL
} // NKikimr
