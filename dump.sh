#!/bin/sh

# Start the entrypoint to start the db
exec /docker-entrypoint.sh postgres >> /tmp/postgres.log 2>&1 &
pid=$!

# Wait for it
while [ ! -S "/var/run/postgresql/.s.PGSQL.5432" ]
do
  sleep 3
  echo "Wait PosgresSQL"
done

echo "PosgresSQL UP"

# Initial full backup
wal-g backup-push $PGDATA
echo "Backup-Push OK $?"

# Enable Archiving
echo "wal_level=replica" >> $PGDATA/postgresql.conf
echo "archive_mode=on" >> $PGDATA/postgresql.conf
echo "archive_command='sh /tmp/archive.sh %p'" >> $PGDATA/postgresql.conf

# Restart because of archiving
echo "Restart $pid"
kill $pid
sleep 4
# use pg_ctl restart ?
exec /docker-entrypoint.sh postgres >> /tmp/postgres.log 2>&1 &

# Wait for it
while [ ! -S "/var/run/postgresql/.s.PGSQL.5432" ]
do
  sleep 3
  echo "Wait PosgresSQL"
done

echo "PosgresSQL UP"

# Fill the DB with pgbench or do anything you like
psql -U $PGUSER -c 'create database bench;'
pgbench -U $PGUSER -i -s 10 bench
pgbench -U $PGUSER -t 100 bench

# Another full backup
wal-g backup-push $PGDATA
echo "Backup-Push OK $?"


