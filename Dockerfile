FROM alpine

RUN echo -e '@testing http://nl.alpinelinux.org/alpine/edge/testing'\
  >> /etc/apk/repositories

RUN apk update && \
    apk add --no-cache cmake git make g++ libtbb@testing libtbb-dev@testing libpng-dev jpeg-dev tiff-dev

RUN cd /tmp && \
    git clone --branch 'master' --single-branch https://github.com/SolSpecSolutions/mvs-texturing && \
    cd /tmp/mvs-texturing && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make -j $(nproc) install && \
    rm -rf /tmp/mvs-texturing

CMD ["/bin/sh"]
