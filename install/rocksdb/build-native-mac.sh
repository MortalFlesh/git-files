#!/usr/bin/env bash

set -e

# see https://gist.github.com/electrum/5528836

brew install snappy

CPPFLAGS=-I/usr/local/include LDFLAGS=-L/usr/local/lib ant compile-native

chmod 644 build/native/Mac_OS_X-x86_64-64/lib/*

ls -l /usr/local/lib/libsnappy.dylib
ls -l build/native/Mac_OS_X-x86_64-64/lib/libhadoop.dylib
