# binfmt-register docker image for arm/aarch64

The purpose of the image is to run arm/aarch64 docker image in x86-64 plaform.
It also can be used in building arm/aarch64 image. I made an example
[yen3/docker-ubuntu-novnc](https://github.com/yen3/docker-ubuntu-novnc).
You can see the project to get more details.

If you use Docker in macOS, you have no need to use the docker image since the
macOSX docker has hypervisor inside.


## Requirement

* docker with privileged access for binfmt_misc register.


## Get the image

* Command memo

    ```bash
    docker pull yen3/binfmt-register:latest
    ```


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

    # Run the image with the qemu static binary
    export MOUNT_QEMU="-v $(pwd)/qemu-${cpu}-static:/usr/local/bin/qemu-${cpu}-static"
    docker run -it --rm ${MOUNT_QEMU} ${RUN_IMAGE} uname -a

    # Unregister binfmt
    docker run --rm --privileged yen3/binfmt-register clear ${cpu}

    # Remove the qemu static binary
    rm -f qemu-${cpu}-static
    ```

## Other example

* `test.sh` provides a simple example for running arm/aarch64 docker images in
  Linux and Darwin(macOS) platform
* The makefile and dockerfiles in [yen3/docker-ubuntu-novnc](https://github.com/yen3/docker-ubuntu-novnc)
  provide an example to build arm/aarch64 docker images in Linux/Darwin
  platform.


## Build the docker image

* Requirement: support multi-stage build (Docker CE v17.05 or newer)
* Build command: `docker build -t yen3/binfmt-register:latest`
    * The source of qemu static binary is from `qemu-user-static` package in
      ubuntu 17.10. The version of qemu is 2.10.1.
* If you have any need to build qemu static binary from source. The example
  dockerfile is in `from_source/Dockerfile`. The build command is

    ```bash
    docker build -t yen3/binfmt-register:laest -f from_source/Dockerfile
    ```

## Reference

* https://en.wikipedia.org/wiki/Binfmt_misc
* https://github.com/moul/docker-binfmt-register
* https://github.com/mikkeloscar/binfmt-manager/blob/master/binfmt_manager
* https://github.com/qemu/qemu/blob/master/scripts/qemu-binfmt-conf.sh
* https://coldnew.github.io/5cecf128/

