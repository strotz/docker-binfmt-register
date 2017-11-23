FROM alpine:edge as builder
RUN apk update \
    && apk add qemu-arm qemu-aarch64

FROM alpine

WORKDIR /qemu

COPY --from=builder /usr/bin/qemu-aarch64 ./qemu-aarch64-static
COPY --from=builder /usr/bin/qemu-arm ./qemu-arm-static
COPY ./qemu-binfmt-register.sh .
COPY ./start.sh .

ENTRYPOINT ["/qemu/start.sh"]

