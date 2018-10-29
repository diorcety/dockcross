#!/usr/bin/env bash

for PIP in /opt/python/*/bin/pip; do
  bindir="$(dirname "$PIP")"
  rootdir="$(dirname "$bindir")"
  LD_LIBRARY_PATH=$rootdir/lib $PIP install --disable-pip-version-check --upgrade pip
  LD_LIBRARY_PATH=$rootdir/lib $PIP install scikit-build==0.8.1
done
