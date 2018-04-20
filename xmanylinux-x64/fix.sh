#!/bin/sh
cd /opt/rh/devtoolset-2/root/usr/lib/gcc
ln -s x86_64-CentOS-linux/ x86_64-redhat-linux
cd /opt/rh/devtoolset-2/root/usr/include/c++/4.8.2/
ln -s x86_64-CentOS-linux/ x86_64-redhat-linux
