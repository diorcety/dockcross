FROM dockcross/linux-x64

ENV DEFAULT_DOCKCROSS_IMAGE dockcross/linux-x64-innoextract

RUN wget http://ftp.us.debian.org/debian/pool/main/g/gettext/autopoint_0.19.3-2_all.deb \
    && dpkg -i autopoint_0.19.3-2_all.deb \
    && rm autopoint_0.19.3-2_all.deb

ARG xz_version=5.2.4
ENV xz_version ${xz_version}

RUN wget https://tukaani.org/xz/xz-${xz_version}.tar.gz \
    && tar xfz xz-${xz_version}.tar.gz \
    && rm xz-${xz_version}.tar.gz \
    && cd xz-${xz_version} \
    && bash autogen.sh \
    && mkdir cbuild && cd cbuild \
    && ../configure --prefix=/usr && make -j4 && make install \
    && cd .. && cd .. && rm -rf xz-${xz_version} && ldconfig

ARG bzip2_version=1.0.6
ENV bzip2_version ${bzip2_version}

RUN wget https://downloads.sourceforge.net/project/bzip2/bzip2-${bzip2_version}.tar.gz \
    && tar xfz bzip2-${bzip2_version}.tar.gz \
    && rm bzip2-${bzip2_version}.tar.gz \
    && cd bzip2-${bzip2_version} \
    && sed -i 's#PREFIX=/usr/local#PREFIX=/usr#g' Makefile && make -j4 && make install \
    && cd .. && rm -rf bzip2-${bzip2_version} && ldconfig

ARG boost_version=1.67.0
ARG boost_dir=boost_1_67_0
ENV boost_version ${boost_version}

RUN wget https://dl.bintray.com/boostorg/release/${boost_version}/source/${boost_dir}.tar.gz \
    && tar xfz ${boost_dir}.tar.gz \
    && rm ${boost_dir}.tar.gz \
    && cd ${boost_dir} \
    && ./bootstrap.sh \
    && ./b2 --without-python --prefix=/usr -j 4 link=static install \
    && cd .. && rm -rf ${boost_dir} && ldconfig
