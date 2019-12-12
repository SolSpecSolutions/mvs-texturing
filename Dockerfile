ARG ALPINE_VERSION=3.10
ARG PCL_VERSION=1.9.1

FROM alpine:${ALPINE_VERSION}

RUN \
    echo "@edgetesting http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \ 
    apk update && \
    apk add --no-cache \
        boost-dev \
        build-base \
        cmake \
        curl \
        git \
        libtbb@edgetesting \
        libtbb-dev@edgetesting \
        libpng-dev \
        jpeg-dev \
        tiff-dev \
        linux-headers


COPY . /tmp/mvs-texturing
# MvsTexturing
RUN \
    cd /tmp/mvs-texturing \
    && mkdir build \
    && cd build \
    && cmake -DCMAKE_BUILD_TYPE=Release .. \
    && make -j $(nproc) install \
    && rm -rf /tmp/mvs-texturing
