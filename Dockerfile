FROM ubuntu:18.04

RUN set -ex \
    && sed -i -- 's/# deb-src/deb-src/g' /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
               build-essential \
               cdbs \
               devscripts \
               equivs \
               fakeroot \
               gcc curl wget git openssh-client ca-certificates  \
    && apt-get clean \
    && rm -rf /tmp/* /var/tmp/*
