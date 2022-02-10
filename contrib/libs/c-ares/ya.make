# Generated by devtools/yamaker from nixpkgs e392df43c9f302d4a0892caaadcad3cd693edf9e.

LIBRARY() 
 
OWNER(
    max42
    g:cpp-contrib
)

VERSION(1.16.1)

ORIGINAL_SOURCE(https://c-ares.haxx.se/download/c-ares-1.16.1.tar.gz)

LICENSE(
    BSD-3-Clause AND
    ISC AND
    MIT AND
    NTP
)

LICENSE_TEXTS(.yandex_meta/licenses.list.txt)

PEERDIR(
    contrib/libs/libc_compat
)

ADDINCL(
    contrib/libs/c-ares
)
 
NO_COMPILER_WARNINGS() 
 
CFLAGS(
    -DCARES_BUILDING_LIBRARY
    -DCARES_SYMBOL_HIDING
    -DHAVE_CONFIG_H
)

IF (NOT DLL_FOR)
    CFLAGS(
        -DCARES_STATICLIB
    )
ENDIF()

IF (ARCH_ARM7)
    CFLAGS(
        GLOBAL -D__SIZEOF_LONG__=4
    )
ENDIF()

SRCS( 
    ares__close_sockets.c 
    ares__get_hostent.c 
    ares__parse_into_addrinfo.c
    ares__read_line.c 
    ares__readaddrinfo.c
    ares__sortaddrinfo.c
    ares__timeval.c 
    ares_android.c
    ares_cancel.c 
    ares_create_query.c 
    ares_data.c 
    ares_destroy.c 
    ares_expand_name.c 
    ares_expand_string.c 
    ares_fds.c 
    ares_free_hostent.c 
    ares_free_string.c 
    ares_freeaddrinfo.c
    ares_getaddrinfo.c
    ares_getenv.c 
    ares_gethostbyaddr.c 
    ares_gethostbyname.c 
    ares_getnameinfo.c 
    ares_getopt.c 
    ares_getsock.c 
    ares_init.c 
    ares_library_init.c 
    ares_llist.c 
    ares_mkquery.c 
    ares_nowarn.c 
    ares_options.c 
    ares_parse_a_reply.c 
    ares_parse_aaaa_reply.c 
    ares_parse_mx_reply.c 
    ares_parse_naptr_reply.c 
    ares_parse_ns_reply.c 
    ares_parse_ptr_reply.c 
    ares_parse_soa_reply.c 
    ares_parse_srv_reply.c 
    ares_parse_txt_reply.c 
    ares_platform.c 
    ares_process.c 
    ares_query.c 
    ares_search.c 
    ares_send.c 
    ares_strcasecmp.c 
    ares_strdup.c 
    ares_strerror.c 
    ares_strsplit.c
    ares_timeout.c 
    ares_version.c 
    ares_writev.c 
    atomic.cpp
    bitncmp.c 
    inet_net_pton.c 
    inet_ntop.c 
    windows_port.c 
) 
 
CHECK_CONFIG_H(ares_setup.h)

END() 

RECURSE(
    acountry
    adig
    ahost
    test
)
