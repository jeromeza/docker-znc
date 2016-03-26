# version 1.6.1-1
# docker-version 1.8.2
FROM docker.io/centos
MAINTAINER Jerome Sheed "jerome@sheed.co.za"

ENV ZNC_VERSION 1.6.1

RUN yum update -y \
    && yum install gcc openssl openssl-devel wget sudo -y \
    && yum group install "Development Tools" -y \
    && mkdir -p /src \
    && cd /src \
    && wget "http://znc.in/releases/archive/znc-${ZNC_VERSION}.tar.gz" \
    && tar -zxf "znc-${ZNC_VERSION}.tar.gz" \
    && cd "znc-${ZNC_VERSION}" \
    && ./configure \
    && make \
    && make install \
    && yum clean all \
    && rm -rf /src* /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd znc
ADD docker-entrypoint.sh /entrypoint.sh
ADD znc.conf.default /znc.conf.default
RUN chmod 644 /znc.conf.default

VOLUME /znc-data

EXPOSE 6667
ENTRYPOINT ["/entrypoint.sh"]
CMD [""]
