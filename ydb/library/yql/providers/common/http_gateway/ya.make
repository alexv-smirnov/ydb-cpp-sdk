LIBRARY()

OWNER(
    g:yq
    g:yql
)

SRCS(
    yql_http_gateway.cpp
)

PEERDIR(
    contrib/libs/curl
    library/cpp/monlib/dynamic_counters
    ydb/library/yql/providers/common/proto
    ydb/library/yql/public/issue
)

YQL_LAST_ABI_VERSION()

END()

