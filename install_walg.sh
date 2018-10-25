#!/bin/sh

# https://github.com/wal-g/wal-g

# Install wal-g with go

go get github.com/wal-g/wal-g && \
cd ~/go/src/github.com/wal-g/wal-g && \
make all && GOBIN=/usr/local/bin make install
