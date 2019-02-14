#!/bin/sh

MACHINE_TYPE=`uname -m`
if [ ${MACHINE_TYPE} == 'x86_64' ]; then
    cd /opt/rh/devtoolset-2/root/usr/lib/gcc
    ln -s x86_64-CentOS-linux/ x86_64-redhat-linux
    cd /opt/rh/devtoolset-2/root/usr/include/c++/4.8.2/
    ln -s x86_64-CentOS-linux/ x86_64-redhat-linux
else
    cd /opt/rh/devtoolset-2/root/usr/lib/gcc
    ln -s i386-CentOS-linux/ i386-redhat-linux
    cd /opt/rh/devtoolset-2/root/usr/include/c++/4.8.2/
    ln -s i386-CentOS-linux/ i386-redhat-linux
fi
