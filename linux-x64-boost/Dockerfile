FROM dockcross/linux-x64

ENV DEFAULT_DOCKCROSS_IMAGE dockcross/linux-x64-boost

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

