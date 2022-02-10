#include "yql_dq_datasource_type_ann.h"

#include <ydb/library/yql/core/expr_nodes/yql_expr_nodes.h>
#include <ydb/library/yql/core/yql_expr_type_annotation.h>
#include <ydb/library/yql/dq/expr_nodes/dq_expr_nodes.h>
#include <ydb/library/yql/dq/type_ann/dq_type_ann.h>
#include <ydb/library/yql/providers/dq/expr_nodes/dqs_expr_nodes.h>
#include <ydb/library/yql/providers/common/provider/yql_provider_names.h>

namespace NYql {

using namespace NNodes;

namespace {

class TDqsDataSourceTypeAnnotationTransformer : public TVisitorTransformerBase {
public:
    TDqsDataSourceTypeAnnotationTransformer()
        : TVisitorTransformerBase(true)
    {
        AddHandler({TDqSourceWrap::CallableName()}, Hndl(&TDqsDataSourceTypeAnnotationTransformer::HandleSourceWrap<false>)); 
        AddHandler({TDqSourceWideWrap::CallableName()}, Hndl(&TDqsDataSourceTypeAnnotationTransformer::HandleSourceWrap<true>)); 
        AddHandler({TDqReadWrap::CallableName()}, Hndl(&TDqsDataSourceTypeAnnotationTransformer::HandleReadWrap)); 
        AddHandler({TDqReadWideWrap::CallableName()}, Hndl(&TDqsDataSourceTypeAnnotationTransformer::HandleWideReadWrap)); 
        AddHandler({TCoConfigure::CallableName()}, Hndl(&TDqsDataSourceTypeAnnotationTransformer::HandleConfig));
        AddHandler({TDqSource::CallableName()}, Hndl(&NDq::AnnotateDqSource));
    }

private:
    TStatus HandleReadWrap(const TExprNode::TPtr& input, TExprContext& ctx) {
        if (!EnsureMinMaxArgsCount(*input, 1, 3, ctx)) { 
            return TStatus::Error;
        }

        if (input->ChildrenSize() > TDqReadWrapBase::idx_Token) { 
            if (!EnsureCallable(*input->Child(TDqReadWrapBase::idx_Token), ctx)) {
                return TStatus::Error;
            }

            if (!TCoSecureParam::Match(input->Child(TDqReadWrapBase::idx_Token))) {
                ctx.AddError(TIssue(ctx.GetPosition(input->Child(TDqReadWrapBase::idx_Token)->Pos()), TStringBuilder() << "Expected " << TCoSecureParam::CallableName()));
                return TStatus::Error;
            }
        }

        if (input->ChildrenSize() > TDqReadWrapBase::idx_Flags && !EnsureTupleOfAtoms(*input->Child(TDqReadWrapBase::idx_Flags), ctx)) { 
            return TStatus::Error; 
        } 
 
        if (!EnsureTupleTypeSize(input->Head(), 2, ctx)) {
            return TStatus::Error;
        }
        const auto readerType = input->Head().GetTypeAnn()->Cast<TTupleExprType>()->GetItems().back(); 
        if (!EnsureListType(input->Head().Pos(), *readerType, ctx)) {
            return TStatus::Error;
        }
        input->SetTypeAnn(readerType); 
        return TStatus::Ok;
    }

    template<bool Wide> 
    TStatus HandleSourceWrap(const TExprNode::TPtr& input, TExprContext& ctx) { 
        if (!EnsureMinMaxArgsCount(*input, 3U, 4U, ctx)) { 
            return TStatus::Error; 
        } 
 
        if (!EnsureNewSeqType<false>(input->Head(), ctx)) { 
            return TStatus::Error; 
        } 
 
        if (!EnsureDataSource(*input->Child(TDqSourceWrapBase::idx_DataSource), ctx)) { 
            return TStatus::Error; 
        } 
 
        const auto& rowType = *input->Child(TDqSourceWrapBase::idx_RowType); 
        if (!EnsureType(rowType, ctx)) { 
            return IGraphTransformer::TStatus::Error; 
        } 
 
        const auto type = input->Child(TDqSourceWrapBase::idx_RowType)->GetTypeAnn()->Cast<TTypeExprType>()->GetType(); 
        if (!EnsureStructType(rowType.Pos(), *type, ctx)) { 
            return IGraphTransformer::TStatus::Error; 
        } 
 
        if (input->ChildrenSize() > TDqSourceWrapBase::idx_Settings && !EnsureTuple(*input->Child(TDqSourceWrapBase::idx_Settings), ctx)) { 
            return TStatus::Error; 
        } 
 
        if constexpr (Wide) { 
            const auto& items = type->Cast<TStructExprType>()->GetItems(); 
            TTypeAnnotationNode::TListType types; 
            types.reserve(items.size()); 
            std::transform(items.cbegin(), items.cend(), std::back_inserter(types), std::bind(&TItemExprType::GetItemType, std::placeholders::_1)); 
            input->SetTypeAnn(ctx.MakeType<TFlowExprType>(ctx.MakeType<TMultiExprType>(types))); 
        } else { 
            input->SetTypeAnn(ctx.MakeType<TListExprType>(input->Child(TDqSourceWrapBase::idx_RowType)->GetTypeAnn()->Cast<TTypeExprType>()->GetType())); 
        } 
 
        return TStatus::Ok; 
    } 
 
    TStatus HandleWideReadWrap(const TExprNode::TPtr& input, TExprContext& ctx) { 
        if (!EnsureMinMaxArgsCount(*input, 1, 3, ctx)) { 
            return TStatus::Error; 
        } 
 
        if (input->ChildrenSize() > TDqReadWrapBase::idx_Token) { 
            if (!EnsureCallable(*input->Child(TDqReadWrapBase::idx_Token), ctx)) { 
                return TStatus::Error; 
            } 
 
            if (!TCoSecureParam::Match(input->Child(TDqReadWrapBase::idx_Token))) { 
                ctx.AddError(TIssue(ctx.GetPosition(input->Child(TDqReadWrapBase::idx_Token)->Pos()), TStringBuilder() << "Expected " << TCoSecureParam::CallableName())); 
                return TStatus::Error; 
            } 
        } 
 
        if (input->ChildrenSize() > TDqReadWrapBase::idx_Flags && !EnsureTupleOfAtoms(*input->Child(TDqReadWrapBase::idx_Flags), ctx)) { 
            return TStatus::Error; 
        } 
 
        if (!EnsureTupleTypeSize(input->Head(), 2, ctx)) { 
            return TStatus::Error; 
        } 
        const auto readerType = input->Head().GetTypeAnn()->Cast<TTupleExprType>()->GetItems().back(); 
        if (!EnsureListType(input->Head().Pos(), *readerType, ctx)) { 
            return TStatus::Error; 
        } 
 
        const auto structType = readerType->Cast<TListExprType>()->GetItemType()->Cast<TStructExprType>(); 
        TTypeAnnotationNode::TListType types; 
        const auto& items = structType->GetItems(); 
        types.reserve(items.size()); 
        std::transform(items.cbegin(), items.cend(), std::back_inserter(types), std::bind(&TItemExprType::GetItemType, std::placeholders::_1)); 
 
        input->SetTypeAnn(ctx.MakeType<TFlowExprType>(ctx.MakeType<TMultiExprType>(types))); 
        return TStatus::Ok; 
    } 
 
    TStatus HandleConfig(const TExprNode::TPtr& input, TExprContext& ctx) {
        if (!EnsureMinArgsCount(*input, 2, ctx)) {
            return TStatus::Error;
        }

        if (!EnsureWorldType(*input->Child(TCoConfigure::idx_World), ctx)) {
            return TStatus::Error;
        }

        if (!EnsureSpecificDataSource(*input->Child(TCoConfigure::idx_DataSource), DqProviderName, ctx)) {
            return TStatus::Error;
        }

        input->SetTypeAnn(input->Child(TCoConfigure::idx_World)->GetTypeAnn());

        return TStatus::Ok;
    }
};

} // unnamed

THolder<TVisitorTransformerBase> CreateDqsDataSourceTypeAnnotationTransformer() {
    return THolder(new TDqsDataSourceTypeAnnotationTransformer());
}

} // NYql
