FROM dockcross/manylinux-x64

ENV DEFAULT_DOCKCROSS_IMAGE dockcross/xmanylinux-x64

ADD fix.sh fix.sh

RUN bash fix.sh

# Specific

ENV PATH="/opt/python/cp27-cp27mu/bin/:${PATH}"

ENV PATH="/opt/llvm/bin:${PATH}"

RUN yum -y install xz

RUN wget http://releases.llvm.org/4.0.0/llvm-4.0.0.src.tar.xz \
    && xz --decompress llvm-4.0.0.src.tar.xz && tar xf llvm-4.0.0.src.tar \
    && rm llvm-4.0.0.src.tar \
    && cd llvm-4.0.0.src \
    && mkdir cbuild && cd cbuild \
    && cmake ../ -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/opt/llvm -DLLVM_TARGETS_TO_BUILD="X86" \
    && cmake --build . -- -j4 && cmake --build . --target install \
    && cd .. && cd .. && rm -rf llvm-4.0.0.src && ldconfig

RUN wget http://releases.llvm.org/4.0.0/cfe-4.0.0.src.tar.xz \
    && xz --decompress cfe-4.0.0.src.tar.xz && tar xf cfe-4.0.0.src.tar \
    && rm cfe-4.0.0.src.tar \
    && cd cfe-4.0.0.src \
    && mkdir cbuild && cd cbuild \
    && cmake ../ -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/opt/llvm -DLLVM_TARGETS_TO_BUILD="X86" \
    && cmake --build . -- -j4 && cmake --build . --target install \
    && cd .. && cd .. && rm -rf cfe-4.0.0.src && ldconfig

RUN wget ftp://sourceware.org/pub/libffi/libffi-3.2.1.tar.gz \
    && tar xvf libffi-3.2.1.tar.gz \
    && rm libffi-3.2.1.tar.gz \
    && cd libffi-3.2.1 \
    && ./configure --prefix=/usr --libdir=/usr/lib64 --enable-static --disable-shared CFLAGS=-fPIC \
    && make -j4 && make install \
    && ln -s /usr/lib/libffi-3.2.1/include /usr/include/libffi \
    && cd .. && rm -rf libffi-3.2.1 && ldconfig

RUN wget http://releases.llvm.org/4.0.0/openmp-4.0.0.src.tar.xz \
    && xz --decompress openmp-4.0.0.src.tar.xz && tar xf openmp-4.0.0.src.tar \
    && rm openmp-4.0.0.src.tar \
    && cd openmp-4.0.0.src \
    && mkdir cbuild && cd cbuild \
    && CXXFLAGS="-fPIC" CFLAGS="-fPIC" cmake ../ -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr -DLIBOMP_ENABLE_SHARED:BOOL=OFF \
    && CXXFLAGS="-fPIC" CFLAGS="-fPIC" cmake --build . -- -j4 && CXXFLAGS="-fPIC" CFLAGS="-fPIC" cmake --build . --target install \
    && cd .. && cd .. && rm -rf openmp-4.0.0.src && ldconfig

RUN yum install -y libX11-devel libXau-devel libXext-devel libXrender-devel

RUN yum install -y libxslt

RUN wget --no-check-certificate https://xcb.freedesktop.org/dist/xcb-proto-1.7.1.tar.gz \
    && tar xvf xcb-proto-1.7.1.tar.gz \
    && rm xcb-proto-1.7.1.tar.gz \
    && cd xcb-proto-1.7.1 \
    && ./configure --prefix=/usr --libdir=/usr/lib64 --enable-static --enable-shared CFLAGS=-fPIC \
    && make -j4 && make install \
    && cd .. && rm -rf xcb-proto-1.7.1 && ldconfig

RUN wget --no-check-certificate https://xcb.freedesktop.org/dist/libpthread-stubs-0.3.tar.gz \
    && tar xvf libpthread-stubs-0.3.tar.gz \
    && rm libpthread-stubs-0.3.tar.gz \
    && cd libpthread-stubs-0.3 \
    && ./configure --prefix=/usr --libdir=/usr/lib64 --enable-static --enable-shared CFLAGS=-fPIC \
    && make -j3 && make install \
    && cd .. && rm -rf libpthread-stubs-0.3 && ldconfig

RUN wget --no-check-certificate https://xcb.freedesktop.org/dist/libxcb-1.8.1.tar.gz \
    && tar xvf libxcb-1.8.1.tar.gz \
    && rm libxcb-1.8.1.tar.gz \
    && cd libxcb-1.8.1 \
    && ./configure --prefix=/usr --libdir=/usr/lib64 --enable-static --enable-shared CFLAGS=-fPIC \
    && make -j4 && make install \
    && cd .. && rm -rf libxcb-1.8.1 && ldconfig

RUN yum install -y fontconfig-devel

RUN cd /opt/ \
    && wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/jdk-8u171-linux-x64.tar.gz" -O jdk-8u171-linux-x64.tar.gz \
    && tar xzf jdk-8u171-linux-x64.tar.gz \
    && rm jdk-8u171-linux-x64.tar.gz

ENV JAVA_HOME="/opt/jdk1.8.0_171"
ENV JRE_HOME="/opt/jdk1.8.0_171/jre"
ENV PATH="/opt/jdk1.8.0_171/bin:/opt/jdk1.8.0_171/jre/bin:${PATH}"

RUN cd /opt \
    && wget https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.3.9/apache-maven-3.3.9-bin.tar.gz \
    && tar xzf apache-maven-3.3.9-bin.tar.gz \
    && rm apache-maven-3.3.9-bin.tar.gz

ENV PATH="/opt/apache-maven-3.3.9/bin:${PATH}"
