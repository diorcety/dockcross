FROM dockcross/manylinux-x86

ENV DEFAULT_DOCKCROSS_IMAGE dockcross/xmanylinux-x86

ADD fix.sh fix.sh

RUN bash fix.sh

RUN yum -y install xz

ENV PATH="/opt/python/cp27-cp27mu/bin/:${PATH}"

# LLVM & Clang
RUN wget http://releases.llvm.org/6.0.0/llvm-6.0.0.src.tar.xz \
    && xz --decompress llvm-6.0.0.src.tar.xz && tar xf llvm-6.0.0.src.tar \
    && rm llvm-6.0.0.src.tar \
    && cd llvm-6.0.0.src \
    && mkdir cbuild && cd cbuild \
    && cmake ../ -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/opt/llvm60 -DLLVM_TARGETS_TO_BUILD="X86" -DLLVM_DEFAULT_TARGET_TRIPLE=i686-unknown-linux-gnu \
    && cmake --build . -- -j4 && cmake --build . --target install \
    && cd .. && cd .. && rm -rf llvm-6.0.0.src && ldconfig

RUN wget http://releases.llvm.org/6.0.0/cfe-6.0.0.src.tar.xz \
    && xz --decompress cfe-6.0.0.src.tar.xz && tar xf cfe-6.0.0.src.tar \
    && rm cfe-6.0.0.src.tar \
    && cd cfe-6.0.0.src \
    && mkdir cbuild && cd cbuild \
    && cmake ../ -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/opt/llvm60 -DLLVM_TARGETS_TO_BUILD="X86" -DLLVM_DEFAULT_TARGET_TRIPLE=i686-unknown-linux-gnu \
    && cmake --build . -- -j4 && cmake --build . --target install \
    && cd .. && cd .. && rm -rf cfe-6.0.0.src && ldconfig

RUN wget http://releases.llvm.org/6.0.0/lld-6.0.0.src.tar.xz \
    && xz --decompress lld-6.0.0.src.tar.xz && tar xf lld-6.0.0.src.tar \
    && rm lld-6.0.0.src.tar \
    && cd lld-6.0.0.src \
    && mkdir cbuild && cd cbuild \
    && cmake ../ -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/opt/llvm60 \
    && cmake --build . -- -j4 && cmake --build . --target install \
    && cd .. && cd .. && rm -rf lld-6.0.0.src && ldconfig

# Missing base libraries and software
RUN yum install -y libX11-devel libXau-devel libXext-devel libXrender-devel

RUN yum install -y libxslt

RUN wget --no-check-certificate https://xcb.freedesktop.org/dist/xcb-proto-1.7.1.tar.gz \
    && tar xvf xcb-proto-1.7.1.tar.gz \
    && rm xcb-proto-1.7.1.tar.gz \
    && cd xcb-proto-1.7.1 \
    && ./configure --prefix=/usr --libdir=/usr/lib --enable-static --enable-shared CFLAGS=-fPIC \
    && make -j4 && make install \
    && cd .. && rm -rf xcb-proto-1.7.1 && ldconfig

RUN wget --no-check-certificate https://xcb.freedesktop.org/dist/libpthread-stubs-0.3.tar.gz \
    && tar xvf libpthread-stubs-0.3.tar.gz \
    && rm libpthread-stubs-0.3.tar.gz \
    && cd libpthread-stubs-0.3 \
    && ./configure --prefix=/usr --libdir=/usr/lib --enable-static --enable-shared CFLAGS=-fPIC \
    && make -j3 && make install \
    && cd .. && rm -rf libpthread-stubs-0.3 && ldconfig

RUN wget --no-check-certificate https://xcb.freedesktop.org/dist/libxcb-1.8.1.tar.gz \
    && tar xvf libxcb-1.8.1.tar.gz \
    && rm libxcb-1.8.1.tar.gz \
    && cd libxcb-1.8.1 \
    && ./configure --prefix=/usr --libdir=/usr/lib --enable-static --enable-shared CFLAGS=-fPIC \
    && make -j4 && make install \
    && cd .. && rm -rf libxcb-1.8.1 && ldconfig

RUN yum install -y fontconfig-devel

RUN yum -y install pcre-devel

# Java
RUN cd /opt/ \
    && wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-i586.tar.gz" -O jdk-8u181-linux-i586.tar.gz \
    && tar xzf jdk-8u181-linux-i586.tar.gz \
    && rm jdk-8u181-linux-i586.tar.gz

# Maven
RUN cd /opt \
    && wget --no-check-certificate http://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.3.9/apache-maven-3.3.9-bin.tar.gz \
    && tar xzf apache-maven-3.3.9-bin.tar.gz \
    && rm apache-maven-3.3.9-bin.tar.gz

# Swig
RUN wget --no-check-certificate http://downloads.sourceforge.net/project/swig/swig/swig-3.0.12/swig-3.0.12.tar.gz \
    && tar xvf swig-3.0.12.tar.gz \
    && rm swig-3.0.12.tar.gz \
    && cd swig-3.0.12 \
    && ./configure --prefix=/usr --libdir=/usr/lib \
    && make -j4 && make install \
    && cd .. && rm -rf swig-3.0.12 && ldconfig

# OpenMP
ADD 0001-openmp-6.0.0.patch /tmp/0001-openmp-6.0.0.patch

RUN wget http://releases.llvm.org/6.0.0/openmp-6.0.0.src.tar.xz \
    && xz --decompress openmp-6.0.0.src.tar.xz && tar xf openmp-6.0.0.src.tar \
    && rm openmp-6.0.0.src.tar \
    && cd openmp-6.0.0.src \
    && patch -p1 < /tmp/0001-openmp-6.0.0.patch \
    && rm /tmp/0001-openmp-6.0.0.patch \
    && mkdir cbuild && cd cbuild \
    && CXXFLAGS="-fPIC" CFLAGS="-fPIC" cmake ../ -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_LIBDIR=lib \
    && CXXFLAGS="-fPIC" CFLAGS="-fPIC" cmake --build . -- -j4 && CXXFLAGS="-fPIC" CFLAGS="-fPIC" cmake --build . --target install \
    && cd .. && cd .. && rm -rf openmp-6.0.0.src && ldconfig

# XSD
RUN wget --no-check-certificate https://www.codesynthesis.com/download/xsd/4.0/linux-gnu/i686/xsd-4.0.0-i686-linux-gnu.tar.bz2 \
    && tar xvf xsd-4.0.0-i686-linux-gnu.tar.bz2 \
    && rm xsd-4.0.0-i686-linux-gnu.tar.bz2 \
    && cp -R xsd-4.0.0-i686-linux-gnu/bin/* /usr/bin \
    && cp -R xsd-4.0.0-i686-linux-gnu/libxsd/* /usr/include \
    && rm -rf xsd-4.0.0-i686-linux-gnu

# Reset PATH
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
ENV LD_LIBRARY_PATH="/usr/local/lib:/usr/local/lib"

# Configure default environment
ENV PATH="/opt/python/cp27-cp27mu/bin/:${PATH}"
ENV PATH="/opt/llvm60/bin:${PATH}"
ENV JAVA_HOME="/opt/jdk1.8.0_181"
ENV JRE_HOME="/opt/jdk1.8.0_181/jre"
ENV PATH="/opt/jdk1.8.0_181/bin:/opt/jdk1.8.0_181/jre/bin:${PATH}"
ENV PATH="/opt/apache-maven-3.3.9/bin:${PATH}"
ENV LD_LIBRARY_PATH="/opt/llvm60/lib:${LD_LIBRARY_PATH}"

ENV CROSS_TRIPLE i686-linux-gnu
ENV CROSS_ROOT /opt/llvm60/bin
ENV AS=${CROSS_ROOT}/llvm-as \
    AR=${CROSS_ROOT}/llvm-ar \
    CC=${CROSS_ROOT}/clang \
    CPP=${CROSS_ROOT}/clang-cpp \
    CXX=${CROSS_ROOT}/clang++ \
    LD=${CROSS_ROOT}/ld.lld \
    LDFLAGS=-fuse-ld=lld
COPY Toolchain.cmake ${CROSS_ROOT}/../lib/
ENV CMAKE_TOOLCHAIN_FILE="/opt/llvm60/lib/Toolchain.cmake"

# Flags
ENV CFLAGS="-march=x86-64 -mtune=generic"
ENV CXXFLAGS="-march=x86-64 -mtune=generic"
ENV FFLAGS="-march=x86-64 -mtune=generic"

# Don't run preexec
RUN rm /dockcross/pre_exec.sh

# Stip is broken
RUN rm /usr/bin/strip && ln -s /opt/rh/devtoolset-2/root/usr/bin/strip /usr/bin/strip

# Remove six from python
RUN /opt/python/cp27-cp27m/bin/python -m pip uninstall -y six
RUN /opt/python/cp27-cp27mu/bin/python -m pip uninstall -y six
RUN /opt/python/cp34-cp34m/bin/python -m pip uninstall -y six
RUN /opt/python/cp35-cp35m/bin/python -m pip uninstall -y six
RUN /opt/python/cp36-cp36m/bin/python -m pip uninstall -y six
RUN /opt/python/cp37-cp37m/bin/python -m pip uninstall -y six

