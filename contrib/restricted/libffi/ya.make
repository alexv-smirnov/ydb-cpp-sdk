# Generated by devtools/yamaker from nixpkgs 5852a21819542e6809f68ba5a798600e69874e76.

LIBRARY()

OWNER(
    borman
    g:cpp-contrib
)

VERSION(3.3)

ORIGINAL_SOURCE(https://sourceware.org/pub/libffi/libffi-3.3.tar.gz)

LICENSE(
    CC-PDDC AND
    MIT
)

LICENSE_TEXTS(.yandex_meta/licenses.list.txt)

ADDINCL(
    contrib/restricted/libffi
    contrib/restricted/libffi/include
    contrib/restricted/libffi/src
    GLOBAL contrib/restricted/libffi/include
)

NO_COMPILER_WARNINGS()

NO_RUNTIME()

CFLAGS(
    -DHAVE_CONFIG_H
    GLOBAL -DFFI_BUILDING
)

SRCS(
    src/closures.c
    src/java_raw_api.c
    src/prep_cif.c
    src/raw_api.c
    src/types.c
)

IF (ARCH_ARM64 AND OS_ANDROID)
    ADDINCL(
        contrib/restricted/libffi/configs/aarch64-unknown-linux-android21
        GLOBAL contrib/restricted/libffi/configs/aarch64-unknown-linux-android21/include
    )
    SRCS(
        src/aarch64/ffi.c
        src/aarch64/sysv.S
    )
ELSEIF (ARCH_ARM64 AND OS_DARWIN)
    ADDINCL(
        contrib/restricted/libffi/configs/aarch64-apple-macos
        GLOBAL contrib/restricted/libffi/configs/aarch64-apple-macos/include
    )
    SRCS(
        src/aarch64/ffi.c
        src/aarch64/sysv.S
    )
ELSEIF (ARCH_ARM64 AND OS_IOS)
    ADDINCL(
        contrib/restricted/libffi/configs/aarch64-apple-iphoneos
        GLOBAL contrib/restricted/libffi/configs/aarch64-apple-iphoneos/include
    )
    SRCS(
        src/aarch64/ffi.c
        src/aarch64/sysv.S
    )
ELSEIF (ARCH_ARM64 AND OS_LINUX)
    ADDINCL(
        contrib/restricted/libffi/configs/aarch64-unknown-linux-gnu
        GLOBAL contrib/restricted/libffi/configs/aarch64-unknown-linux-gnu/include
    )
    SRCS(
        src/aarch64/ffi.c
        src/aarch64/sysv.S
    )
ELSEIF (ARCH_ARM7 AND OS_ANDROID)
    ADDINCL(
        contrib/restricted/libffi/configs/armv7a-unknown-linux-androideabi16
        GLOBAL contrib/restricted/libffi/configs/armv7a-unknown-linux-androideabi16/include
    )
    SRCS(
        src/arm/ffi.c
        src/arm/sysv.S
    )
ELSEIF (ARCH_ARM7 AND OS_IOS)
    ADDINCL(
        contrib/restricted/libffi/configs/armv7-apple-iphoneos
        GLOBAL contrib/restricted/libffi/configs/armv7-apple-iphoneos/include
    )
    SRCS(
        src/arm/ffi.c
        src/arm/sysv.S
    )
ELSEIF (ARCH_ARM7 AND OS_LINUX)
    ADDINCL(
        contrib/restricted/libffi/configs/armv7a-unknown-linux-gnueabihf
        GLOBAL contrib/restricted/libffi/configs/armv7a-unknown-linux-gnueabihf/include
    )
    SRCS(
        src/arm/ffi.c
        src/arm/sysv.S
    )
ELSEIF (ARCH_I386 AND OS_ANDROID)
    ADDINCL(
        contrib/restricted/libffi/configs/i686-pc-linux-android16
        GLOBAL contrib/restricted/libffi/configs/i686-pc-linux-android16/include
    )
    SRCS(
        src/x86/ffi.c
        src/x86/sysv.S
    )
ELSEIF (ARCH_I386 AND OS_IOS)
    ADDINCL(
        contrib/restricted/libffi/configs/i386-apple-iphonesimulator
        GLOBAL contrib/restricted/libffi/configs/i386-apple-iphonesimulator/include
    )
    SRCS(
        src/x86/ffi.c
        src/x86/sysv.S
    )
ELSEIF (ARCH_I386 AND OS_WINDOWS)
    ADDINCL(
        contrib/restricted/libffi/configs/i386-microsoft-windows
        GLOBAL contrib/restricted/libffi/configs/i386-microsoft-windows/include
    )
    SRCS(
        configs/i386-microsoft-windows/sysv_intel.masm
        src/x86/ffi.c
    )
ELSEIF (ARCH_PPC64LE AND OS_LINUX)
    ADDINCL(
        contrib/restricted/libffi/configs/powerpc64le-unknown-linux-gnu
        GLOBAL contrib/restricted/libffi/configs/powerpc64le-unknown-linux-gnu/include
    )
    SRCS(
        src/powerpc/ffi.c
        src/powerpc/ffi_linux64.c
        src/powerpc/ffi_sysv.c
        src/powerpc/linux64.S
        src/powerpc/linux64_closure.S
        src/powerpc/ppc_closure.S
        src/powerpc/sysv.S
    )
ELSEIF (ARCH_X86_64 AND OS_ANDROID)
    ADDINCL(
        contrib/restricted/libffi/configs/x86_64-pc-linux-android21
        GLOBAL contrib/restricted/libffi/configs/x86_64-pc-linux-android21/include
    )
    SRCS(
        src/x86/ffi64.c
        src/x86/ffiw64.c
        src/x86/unix64.S
        src/x86/win64.S
    )
ELSEIF (ARCH_X86_64 AND OS_DARWIN)
    ADDINCL(
        contrib/restricted/libffi/configs/x86_64-apple-macosx
        GLOBAL contrib/restricted/libffi/configs/x86_64-apple-macosx/include
    )
    SRCS(
        src/x86/ffi64.c
        src/x86/ffiw64.c
        src/x86/unix64.S
        src/x86/win64.S
    )
ELSEIF (ARCH_X86_64 AND OS_IOS)
    ADDINCL(
        contrib/restricted/libffi/configs/x86_64-apple-iphonesimulator
        GLOBAL contrib/restricted/libffi/configs/x86_64-apple-iphonesimulator/include
    )
    SRCS(
        src/x86/ffi64.c
        src/x86/ffiw64.c
        src/x86/unix64.S
        src/x86/win64.S
    )
ELSEIF (ARCH_X86_64 AND OS_LINUX)
    ADDINCL(
        contrib/restricted/libffi/configs/x86_64-pc-linux-gnu
        GLOBAL contrib/restricted/libffi/configs/x86_64-pc-linux-gnu/include
    )
    SRCS(
        src/x86/ffi64.c
        src/x86/ffiw64.c
        src/x86/unix64.S
        src/x86/win64.S
    )
ELSEIF (ARCH_X86_64 AND OS_WINDOWS)
    ADDINCL(
        contrib/restricted/libffi/configs/x86_64-microsoft-windows
        GLOBAL contrib/restricted/libffi/configs/x86_64-microsoft-windows/include
    )
    SRCS(
        configs/x86_64-microsoft-windows/win64_intel.masm
        src/x86/ffiw64.c
    )
ELSE()
    MESSAGE(FATAL_ERROR Unsupported libffi platform: ${TARGET_PLATFORM} / ${HARDWARE_TYPE})
ENDIF()

END()

RECURSE(
    testsuite
)
