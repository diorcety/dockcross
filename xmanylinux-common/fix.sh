#!/bin/sh

if test ${LIB_DIR} = "lib64"; then
    echo "Arch x86_64"
    cd /opt/rh/devtoolset-2/root/usr/lib/gcc
    ln -s x86_64-CentOS-linux/ x86_64-redhat-linux
    cd /opt/rh/devtoolset-2/root/usr/include/c++/4.8.2/
    ln -s x86_64-CentOS-linux/ x86_64-redhat-linux
else
    echo "Arch i686"
    cd /opt/rh/devtoolset-2/root/usr/lib/gcc
    ln -s i386-CentOS-linux/ i386-redhat-linux
    cd /opt/rh/devtoolset-2/root/usr/include/c++/4.8.2/
    ln -s i386-CentOS-linux/ i386-redhat-linux
fi
