FROM alpine:3.3

# Link the musl libc library to the location where Go expects it to be.
# http://stackoverflow.com/questions/34729748/installed-go-binary-not-found-in-path-on-alpine-linux-docker
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

ENV INFLUXDB_VERSION 0.13.0
RUN apk add --no-cache --virtual .build-deps wget gpgme tar ca-certificates && \
    update-ca-certificates && \
    gpg --keyserver hkp://ha.pool.sks-keyservers.net \
        --recv-keys 05CE15085FC09D18E99EFB22684A14CF2582E0C5 && \
    wget -q https://dl.influxdata.com/influxdb/releases/influxdb-${INFLUXDB_VERSION}_linux_amd64.tar.gz.asc && \
    wget -q https://dl.influxdata.com/influxdb/releases/influxdb-${INFLUXDB_VERSION}_linux_amd64.tar.gz && \
    gpg --batch --verify influxdb-${INFLUXDB_VERSION}_linux_amd64.tar.gz.asc influxdb-${INFLUXDB_VERSION}_linux_amd64.tar.gz && \
    mkdir -p /usr/src && \
    tar -C /usr/src -xzf influxdb-${INFLUXDB_VERSION}_linux_amd64.tar.gz && \
    chmod +x /usr/src/*/usr/bin/* && \
    cp -a /usr/src/influxdb-*/* / && \
    rm -rf *.tar.gz* /usr/src /root/.gnupg && \
    apk del .build-deps
COPY influxdb.conf /etc/influxdb/influxdb.conf

EXPOSE 8083 8086

VOLUME /var/lib/influxdb

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["influxd"]
