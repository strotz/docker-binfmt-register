#!/bin/sh

fun=$1
cpu=$2

if [ x"$cpu" != x"arm" ] || [ x"$cpu" != x"aarch64" ]; then
    echo "Only support arm and aarch64"
    exit 1
fi

if [ x"$fun" != x"set" ] || [ x"$fun" != x"clear" ]; then
    echo "set or clearn binfmt_misc"
    exit 1
fi

./qemu-binfmt-register.sh $1 $2

if [ x"$fun" == x"set" ]; then
    cat qemu-$cpu-static
fi

