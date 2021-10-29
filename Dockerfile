FROM debian:bullseye

RUN apt-get update && apt-get install -y crossbuild-essential-armhf crossbuild-essential-arm64 build-essential curl bzip2

RUN mkdir /src /bins && curl -s https://busybox.net/downloads/busybox-1.34.1.tar.bz2 | tar --strip-components=1 -C /src -xjf -

COPY busybox.config /src/.config

ENV SOURCE_DATE_EPOCH 1600000000

RUN cd /src && make CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 -j$(nproc) busybox && cp /src/busybox /bins/busybox.arm64
RUN cd /src && make CROSS_COMPILE=arm-linux-gnueabihf- ARCH=arm -j$(nproc) busybox && cp /src/busybox /bins/busybox.arm
RUN cd /src && make clean && make -j$(nproc) busybox && cp /src/busybox /bins/busybox.amd64
