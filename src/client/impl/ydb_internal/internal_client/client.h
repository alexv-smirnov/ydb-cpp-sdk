#pragma once

#include <src/client/impl/ydb_internal/internal_header.h>

#include <src/client/impl/ydb_internal/common/types.h>
#include <ydb-cpp-sdk/client/types/ydb.h>
#include <src/client/types/core_facility/core_facility.h>

#include <ydb-cpp-sdk/library/threading/future/future.h>
#include <ydb-cpp-sdk/library/logger/log.h>

namespace NMonitoring {
    class IMetricRegistry;
    class TMetricRegistry;
}

namespace NYdb {

class TDbDriverState;
struct TListEndpointsResult;

class IInternalClient {
public:
    virtual NThreading::TFuture<TListEndpointsResult> GetEndpoints(std::shared_ptr<TDbDriverState> dbState) = 0;
    virtual void AddPeriodicTask(TPeriodicCb&& cb, TDuration period) = 0;
#ifndef YDB_GRPC_BYPASS_CHANNEL_POOL
    virtual void DeleteChannels(const std::vector<std::string>& endpoints) = 0;
#endif
    virtual TBalancingSettings GetBalancingSettings() const = 0;
    virtual bool StartStatCollecting(::NMonitoring::IMetricRegistry* sensorsRegistry) = 0;
    virtual ::NMonitoring::TMetricRegistry* GetMetricRegistry() = 0;
    virtual const TLog& GetLog() const = 0;
};

} // namespace NYdb
