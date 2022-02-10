UNITTEST_FOR(ydb/public/lib/json_value) 

OWNER(
    pnv1
    g:kikimr
)

TIMEOUT(600)
 
SIZE(MEDIUM)

FORK_SUBTESTS()

SRCS(
    ydb_json_value_ut.cpp
)

PEERDIR(
    library/cpp/json 
    library/cpp/testing/unittest
    ydb/public/sdk/cpp/client/ydb_proto 
)

END()
