# Generated by devtools/yamaker.

LIBRARY()

WITHOUT_LICENSE_TEXTS()

LICENSE(NCSA)

PEERDIR(
    contrib/libs/llvm12
    contrib/libs/llvm12/include
    contrib/libs/llvm12/lib/Support
)

NO_COMPILER_WARNINGS()

NO_UTIL()

SRCS(
    ACC.cpp
)

END()
