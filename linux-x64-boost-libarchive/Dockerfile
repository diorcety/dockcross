FROM dockcross/linux-x64-boost

ENV DEFAULT_DOCKCROSS_IMAGE dockcross/linux-x64-boost-libarchive

ARG libarchive_version=3.3.2
ENV libarchive_version ${libarchive_version}

RUN wget https://www.libarchive.org/downloads/libarchive-${libarchive_version}.tar.gz \
    && tar xfz libarchive-${libarchive_version}.tar.gz \
    && rm libarchive-${libarchive_version}.tar.gz \
    && cd libarchive-${libarchive_version} \
    && mkdir cbuild && cd cbuild \
    && cmake ../ -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr && cmake --build . -- -j4 && cmake --build . --target install \
    && cd .. && cd .. && rm -rf libarchive-${libarchive_version} && ldconfig

