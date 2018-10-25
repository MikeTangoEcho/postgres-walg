#!/bin/sh

wal-g wal-push $PGDATA/$1
echo "Wal-Push OK $1 $?"

