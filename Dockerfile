FROM debian:jessie
MAINTAINER Matt McCormick "matt.mccormick@kitware.com"

RUN apt-get update && apt-get -y install \
  automake \
  autogen \
  bash \
  build-essential \
  bzip2 \
  curl \
  file \
  git \
  gzip \
  libssl-dev \
  make \
  ncurses-dev \
  pkg-config \
  python \
  rsync \
  sed \
  tar \
  vim \
  wget \
  xz-utils

# Build and install CMake from source.
WORKDIR /usr/src
RUN git clone git://cmake.org/cmake.git CMake && \
  cd CMake && \
  git checkout v3.3.0-rc1
RUN mkdir CMake-build
WORKDIR /usr/src/CMake-build
RUN /usr/src/CMake/bootstrap \
    --parallel=$(nproc) \
    --prefix=/usr && \
  make -j$(nproc) install && \
  rm -rf *
WORKDIR /usr/src

# Build and install Ninja from source
RUN git clone https://github.com/martine/ninja.git && \
  cd ninja && \
  git checkout v1.5.3 && \
  python ./configure.py --bootstrap && \
  ./ninja && \
  cp ./ninja /usr/bin/
