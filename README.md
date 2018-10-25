# Docker + Postgres + Wal-G

Docker with scripts to ease process of testing backup and restoration of postgres + wal-g + s3
TODO add process to check data integrity, custom tailored for user


## Build

```
docker build -t postgres-walg .
```

## Requirement

Copy and fill the file `docker-env-file.example` according to your environment.
You can add wal-g and postgres environments variables.
```
AWS_ACCESS_KEY_ID=*required*
AWS_SECRET_ACCESS_KEY=*required*
AWS_REGION=*required (avoid adding permissions on aws)*
WALG_S3_PREFIX=*required (s3://bucket-name/custom-path)*
PGHOST=/var/run/postgresql
PGUSER=postgres
```

AWS User creds used must at least have these permissions
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::bucket-name"
            ]
        },
        {
            "Action": [
                "s3:*"
            ],
            "Effect": "Allow",
            "Resource": "arn:aws:s3:::bucket-name/*"
        }
    ]
}
```

## Dump

* Start the DB
* Set up wal_archiving and restart the DB
* execute a full backup
* Use pgbench to fill it
* execute a full backup
* Quit


```
docker run --env-file [your env file] postgres-walg sh /root/dump.sh
```

## Load

* Fetch the backup
* Set up recovery.conf
* Start the DB

```
docker run --env-file [your env file] postgres-walg sh /root/load.sh
```

