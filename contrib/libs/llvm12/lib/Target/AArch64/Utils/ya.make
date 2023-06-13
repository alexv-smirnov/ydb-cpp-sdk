# Generated by devtools/yamaker.

LIBRARY()

LICENSE(Apache-2.0 WITH LLVM-exception)

LICENSE_TEXTS(.yandex_meta/licenses.list.txt)

PEERDIR(
    contrib/libs/llvm12
    contrib/libs/llvm12/include
    contrib/libs/llvm12/lib/Support
)

ADDINCL(
    ${ARCADIA_BUILD_ROOT}/contrib/libs/llvm12/lib/Target/AArch64
    contrib/libs/llvm12/lib/Target/AArch64
    contrib/libs/llvm12/lib/Target/AArch64/Utils
)

NO_COMPILER_WARNINGS()

NO_UTIL()

SRCS(
    AArch64BaseInfo.cpp
)

END()
