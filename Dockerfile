FROM debian:bullseye

RUN apt-get update && apt-get install -y crossbuild-essential-armhf crossbuild-essential-arm64 build-essential curl bzip2

RUN mkdir /src /bins && curl -s https://busybox.net/downloads/busybox-1.34.1.tar.bz2 | tar --strip-components=1 -C /src -xjf -

RUN curl -s https://musl.cc/aarch64-linux-musl-cross.tgz | tar -C /opt -xzf - && \
    curl -s https://musl.cc/armv5l-linux-musleabihf-cross.tgz | tar -C /opt -xzf - && \
    curl -s https://musl.cc/x86_64-linux-musl-cross.tgz | tar -C /opt -xzf -

COPY busybox.config /src/.config

ENV SOURCE_DATE_EPOCH 1600000000

RUN cd /src && make clean && PATH=/opt/aarch64-linux-musl-cross/bin:$PATH make CROSS_COMPILE=aarch64-linux-musl- ARCH=arm64 -j$(nproc) busybox && cp /src/busybox /bins/busybox.arm64
RUN cd /src && make clean && PATH=/opt/armv5l-linux-musleabihf-cross/bin:$PATH make CROSS_COMPILE=armv5l-linux-musleabihf- ARCH=arm -j$(nproc) busybox && cp /src/busybox /bins/busybox.arm
RUN cd /src && make clean && PATH=/opt/x86_64-linux-musl-cross/bin:$PATH make CROSS_COMPILE=x86_64-linux-musl- -j$(nproc) busybox && cp /src/busybox /bins/busybox.amd64
