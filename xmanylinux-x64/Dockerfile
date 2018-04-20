FROM dockcross/manylinux-x64

ENV DEFAULT_DOCKCROSS_IMAGE dockcross/xmanylinux-x64

# Setup environment.
ENV PATH /opt/llvm/bin:$PATH

# Default command on startup.
CMD bash

# Copy install-clang over.
RUN git clone -b x https://github.com/diorcety/install-clang.git /opt/install-clang

# Clone
RUN /opt/install-clang/install-clang -s 3 /opt/llvm

# Compile and install LLVM/clang. We delete the source directory to
# avoid committing it to the image.
ARG PATH /opt/python/cp27-cp27m/bin/:$PATH
RUN /opt/install-clang/install-clang -j 4 -c -C /opt/llvm
