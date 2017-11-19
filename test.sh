#!/bin/bash

binfmt_image="yen3/binfmt-register"
platform=$(uname)
mount_option=""

set_binfmt() {
    cpu=$1
    qemu_bin="qemu-${cpu}-static"

    docker run --privileged --rm ${binfmt_image} set ${cpu}
    docker run --rm ${binfmt_image} get ${cpu} > ${qemu_bin}
    chmod +x qemu-${cpu}-static

    mount_option="-v $(pwd)/${qemu_bin}:/usr/local/bin/${qemu_bin}"
}

clear_binfmt() {
    cpu=$1
    qemu_bin="qemu-${cpu}-static"

    docker run --privileged --rm ${binfmt_image} clear ${cpu}
    rm -f ${qemu_bin}
}

run_uname() {
    cpu=$1
    run_image=$2

    [ x"$platform" == x"Linux" ] && set_binfmt $cpu

    docker run -it --rm ${mount_option} ${run_image} uname -a

    [ x"$platform" == x"Linux" ] && clear_binfmt $cpu
}

check_os() {
    if [ x"$platform" != x"Linux" ] && [ x"$platform" != x"Darwin" ]; then
        exit 1
    fi
}

build_binfmt_image() {
    docker build -t ${binfmt_image}  .
}

build_binfmt_image
run_uname "arm" "arm32v7/ubuntu"
run_uname "aarch64" "arm64v8/ubuntu"
