#!/bin/sh

# Fetch latest backup and change it for anything you like
wal-g backup-fetch $PGDATA LATEST
# Add recovery file
echo "restore_command = 'sh /tmp/restore.sh %f %p'" > $PGDATA/recovery.conf
# Start DB and let it Go !
exec /docker-entrypoint.sh postgres
