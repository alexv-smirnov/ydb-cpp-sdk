# Generated by devtools/yamaker.

LIBRARY()

LICENSE(Apache-2.0)

LICENSE_TEXTS(.yandex_meta/licenses.list.txt)

PEERDIR(
    contrib/restricted/abseil-cpp-tstring/y_absl/base
    contrib/restricted/abseil-cpp-tstring/y_absl/debugging
    contrib/restricted/abseil-cpp-tstring/y_absl/numeric
    contrib/restricted/abseil-cpp-tstring/y_absl/profiling
    contrib/restricted/abseil-cpp-tstring/y_absl/strings
    contrib/restricted/abseil-cpp-tstring/y_absl/synchronization
    contrib/restricted/abseil-cpp-tstring/y_absl/time
    contrib/restricted/abseil-cpp-tstring/y_absl/types
)

ADDINCL(
    GLOBAL contrib/restricted/abseil-cpp-tstring
)

NO_COMPILER_WARNINGS()

SRCS(
    status.cc
    status_payload_printer.cc
)

END()
