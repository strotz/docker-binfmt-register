# binfmt-register docker for arm/aarch64

The purpose of the image is to run arm/aarch64 docker image in x86-64 plaform.
It also can be used in building arm/aarch64 image. I made an example
[yen3/docker-ubuntu-novnc](https://github.com/yen3/docker-ubuntu-novnc).
You can see the project to get more details.

If you use Docker in macOS, you have no need to use the docker image since the
macOSX docker has hypervisor inside.


## Requirement

* docker with privileged access for binfmt_misc register.


## Usage

* Command example (in Ubuntu 16.04). You can replace the first two lines
  with `export CPU=aarch64` and `export RUN_IMAGE=arm64v8/alpine` to test
  aarch64

    ```bash
    export CPU=arm
    export RUN_IMAGE=arm32v7/alpine

    # Register binfmt
    docker run --rm --privileged yen3/binfmt-register set ${cpu}

    # Get qemu static binary
    docker run --rm yen3/binfmt-register get ${cpu} > qemu-${cpu}-static
    chmod +x qemu-${cpu}-static

    # Run the real what you want
    export MOUNT_QEMU="-v $(pwd)/qemu-${cpu}-static:/usr/local/bin/qemu-${cpu}-static"
    docker run -it --rm ${MOUNT_QEMU} ${RUN_IMAGE} uname -a

    # Unregister binfmt
    docker run --rm --privileged yen3/binfmt-register clear ${cpu}

    # Remove the qemu static binary
    rm -f qemu-${cpu}-static
    ```


## Reference

* https://en.wikipedia.org/wiki/Binfmt_misc
* https://github.com/moul/docker-binfmt-register
* https://github.com/mikkeloscar/binfmt-manager/blob/master/binfmt_manager
* https://github.com/qemu/qemu/blob/master/scripts/qemu-binfmt-conf.sh
* https://coldnew.github.io/5cecf128/

