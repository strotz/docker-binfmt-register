FROM ubuntu:17.04 as builder
RUN apt update && apt install -y qemu-user-static

FROM alpine

WORKDIR /qemu

COPY --from=builder /usr/bin/qemu-aarch64-static .
COPY --from=builder /usr/bin/qemu-arm-static .
COPY ./qemu-binfmt-register.sh .
COPY ./start.sh . 

ENTRYPOINT ["/qemu/start.sh"]

