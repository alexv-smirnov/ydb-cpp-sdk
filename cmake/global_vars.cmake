set(COMMON_PROTOC_FLAGS -I=${CMAKE_SOURCE_DIR} -I=${CMAKE_BINARY_DIR})
set(YASM_FLAGS -f elf64 -D UNIX -D _x86_64_ -D_YASM_ -g dwarf2)
set(BISON_FLAGS -v)
set(RAGEL_FLAGS -L -I ${CMAKE_SOURCE_DIR}/)
