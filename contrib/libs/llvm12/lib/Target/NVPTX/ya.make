# Generated by devtools/yamaker.

LIBRARY()

LICENSE(Apache-2.0 WITH LLVM-exception)

LICENSE_TEXTS(.yandex_meta/licenses.list.txt)

PEERDIR(
    contrib/libs/llvm12
    contrib/libs/llvm12/include
    contrib/libs/llvm12/lib/Analysis
    contrib/libs/llvm12/lib/CodeGen
    contrib/libs/llvm12/lib/CodeGen/AsmPrinter
    contrib/libs/llvm12/lib/CodeGen/SelectionDAG
    contrib/libs/llvm12/lib/IR
    contrib/libs/llvm12/lib/MC
    contrib/libs/llvm12/lib/Support
    contrib/libs/llvm12/lib/Target
    contrib/libs/llvm12/lib/Target/NVPTX/MCTargetDesc
    contrib/libs/llvm12/lib/Target/NVPTX/TargetInfo
    contrib/libs/llvm12/lib/Transforms/IPO
    contrib/libs/llvm12/lib/Transforms/Scalar
    contrib/libs/llvm12/lib/Transforms/Utils
    contrib/libs/llvm12/lib/Transforms/Vectorize
)

ADDINCL(
    ${ARCADIA_BUILD_ROOT}/contrib/libs/llvm12/lib/Target/NVPTX
    contrib/libs/llvm12/lib/Target/NVPTX
)

NO_COMPILER_WARNINGS()

NO_UTIL()

SRCS(
    NVPTXAllocaHoisting.cpp
    NVPTXAsmPrinter.cpp
    NVPTXAssignValidGlobalNames.cpp
    NVPTXFrameLowering.cpp
    NVPTXGenericToNVVM.cpp
    NVPTXISelDAGToDAG.cpp
    NVPTXISelLowering.cpp
    NVPTXImageOptimizer.cpp
    NVPTXInstrInfo.cpp
    NVPTXLowerAggrCopies.cpp
    NVPTXLowerAlloca.cpp
    NVPTXLowerArgs.cpp
    NVPTXMCExpr.cpp
    NVPTXPeephole.cpp
    NVPTXPrologEpilogPass.cpp
    NVPTXProxyRegErasure.cpp
    NVPTXRegisterInfo.cpp
    NVPTXReplaceImageHandles.cpp
    NVPTXSubtarget.cpp
    NVPTXTargetMachine.cpp
    NVPTXTargetTransformInfo.cpp
    NVPTXUtilities.cpp
    NVVMIntrRange.cpp
    NVVMReflect.cpp
)

END()
