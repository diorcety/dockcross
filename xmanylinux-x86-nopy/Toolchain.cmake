set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR i686)
set(CMAKE_CROSSCOMPILING FALSE)

set(cross_triple "i686-linux-gnu")

set(CMAKE_LINKER /opt/llvm100/bin/ld.lld)
set(CMAKE_C_COMPILER /opt/llvm100/bin/clang)
set(CMAKE_CXX_COMPILER /opt/llvm100/bin/clang++)
set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER})
set(CMAKE_ASM_COMPILER_ID Clang)
set(CMAKE_Fortran_COMPILER /opt/rh/devtoolset-8/root/usr/bin/gfortran)

set(CMAKE_CROSSCOMPILING_EMULATOR /usr/bin/${cross_triple}-noop)

set(CMAKE_INSTALL_LIBDIR lib)
