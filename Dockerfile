FROM postgres:10-alpine

RUN apk --update add \
  build-base \
  cmake \
  go \
  git

# Install Brotli
COPY install_brotli.sh /tmp/install_brotli.sh
RUN sh /tmp/install_brotli.sh

# Install Wal-g
COPY install_walg.sh /tmp/install_walg.sh
RUN sh /tmp/install_walg.sh

COPY dump.sh /root/dump.sh
COPY load.sh /root/load.sh
COPY --chown=postgres:postgres archive.sh /tmp/archive.sh
COPY --chown=postgres:postgres restore.sh /tmp/restore.sh
