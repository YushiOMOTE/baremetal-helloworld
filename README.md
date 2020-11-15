# A x86 bare-metal hello-world in Rust

[![Actions Status](https://github.com/YushiOMOTE/baremetal-helloworld/workflows/run/badge.svg)](https://github.com/YushiOMOTE/baremetal-helloworld/actions)

A minimum example for x86 bare-metal in Rust.

### Build

Install dependencies.

```sh
make setup
```

Build the image.

```sh
make build
```

### Run

Run on QEMU.

```
$ make run
```

(requires `qemu-system-x86_64`)
