FROM ubuntu:16.04 as builder

# Use tw's mirror
RUN sed -i 's/archive.ubuntu.com/tw.archive.ubuntu.com/g' /etc/apt/sources.list

# Install build prerequisties
RUN apt-get update \
    && apt-get install -y autoconf libtool bison flex wget python pkg-config \
        zlib1g zlib1g-dev libglib2.0-dev build-essential

# Install qemu-aarch64-static
RUN mkdir -p /qemu \
    && mkdir -p /qemu/build \
    && cd /qemu \
    && wget https://download.qemu.org/qemu-2.10.1.tar.xz \
    && tar xf qemu-2.10.1.tar.xz \
    && echo "Start to build qemu" \
    && cd build \
    && ../qemu-2.10.1/configure --prefix=/qemu/qemu-static \
       --target-list=aarch64-linux-user,arm-linux-user --static \
    && make -j8 \
    && make install


FROM alpine

WORKDIR /qemu

COPY --from=builder /qemu/qemu-static/bin/qemu-aarch64  ./qemu-aarch64-static
COPY --from=builder /qemu/qemu-static/bin/qemu-arm  ./qemu-arm-static
COPY ./qemu-binfmt-register.sh .
COPY ./start.sh .

ENTRYPOINT ["/qemu/start.sh"]
