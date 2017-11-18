#!/bin/bash

docker build -t yen3/test .

# aarch64
docker run --privileged --rm yen3/test set aarch64
docker run --rm yen3/test get aarch64 > qemu-aarch64-static
chmod +x qemu-aarch64-static
docker run -it --rm -v $(pwd)/qemu-aarch64-static:/usr/local/bin/qemu-aarch64-static arm64v8/ubuntu uname -a
docker run --privileged --rm yen3/test clear aarch64

# arm
docker run --privileged --rm yen3/test set arm
docker run --rm yen3/test get arm > qemu-arm-static
chmod +x qemu-arm-static
docker run -it --rm -v $(pwd)/qemu-arm-static:/usr/local/bin/qemu-arm-static arm32v7/ubuntu uname -a
docker run --privileged --rm yen3/test clear arm
