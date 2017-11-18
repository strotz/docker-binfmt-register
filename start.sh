#!/bin/sh

fun=$1
cpu=$2

if [ x"$fun" == x"sh" ]; then
    sh
    exit 0
fi

if [ x"$cpu" != x"arm" ] && [ x"$cpu" != x"aarch64" ]; then
    echo "only support arm and aarch64"
    exit 1
fi

if [ x"$fun" == x"get" ]; then
    cat /qemu/qemu-$cpu-static
else
    if [ x"$fun" != x"set" ] && [ x"$fun" != x"clear" ]; then
        echo "set or clearn binfmt_misc"
        exit 1
    fi

    /qemu/qemu-binfmt-register.sh $1 $2
fi

