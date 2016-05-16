FROM alpine:3.3

# Link the musl libc library to the location where Go expects it to be.
# http://stackoverflow.com/questions/34729748/installed-go-binary-not-found-in-path-on-alpine-linux-docker
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

ENV INFLUXDB_VERSION 0.13.0
RUN apk add --no-cache --virtual .build-deps wget tar ca-certificates && \
    update-ca-certificates && \
    wget -q https://dl.influxdata.com/influxdb/releases/influxdb-${INFLUXDB_VERSION}_linux_amd64.tar.gz && \
    mkdir -p /usr/src && \
    tar -C /usr/src -xzf influxdb-${INFLUXDB_VERSION}_linux_amd64.tar.gz && \
    chmod +x /usr/src/*/usr/bin/* && \
    cp -a /usr/src/influxdb-*/* / && \
    rm -rf *.tar.gz /usr/src && \
    apk del .build-deps
COPY influxdb.conf /etc/influxdb/influxdb.conf

EXPOSE 8083 8086

VOLUME /var/lib/influxdb

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["influxd"]
