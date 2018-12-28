ARG SRS_VERSION=lino-v2.0-r5

FROM debian:jessie AS build

ARG SRS_VERSION
ENV SRS_VERSION=${SRS_VERSION}
# for health check
ENV SRS_CONFIGURE_ARGS=--with-http-api

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends wget ca-certificates sudo python net-tools; \
    cd /tmp; \
    wget https://github.com/lino-network/srs/archive/${SRS_VERSION}.tar.gz; \
    tar zxf ${SRS_VERSION}.tar.gz; \
    cd srs-${SRS_VERSION}/trunk; \
    ./configure --prefix=/srs ${SRS_CONFIGURE_ARGS}; \
    make; \
    make install; \
    rm -rf /tmp/*; \
    rm -rf /var/lib/apt/lists/*;
COPY ./docker.conf /srs/conf/docker.conf

FROM debian:jessie-slim AS dist
ARG SRS_VERSION
ENV SRS_VERSION=${SRS_VERSION}
EXPOSE 1935 1985 8080
COPY --from=build /srs /srs
WORKDIR /srs
RUN touch /srs/objs/nginx/html/health
CMD ["./objs/srs", "-c", "./conf/docker.conf"]

