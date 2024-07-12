# A x86 bare-metal hello-world in Rust

[![Actions Status](https://github.com/YushiOMOTE/baremetal-helloworld/workflows/build/badge.svg)](https://github.com/YushiOMOTE/baremetal-helloworld/actions)

A minimum example for x86 bare-metal in Rust. As of 2024/07.

### Setup

Use `nightly`

```sh
rustup target add x86_64-unknown-none
rustup component add rust-src
rustup component add llvm-tools-preview
```

### Build

```sh
cargo build
```

### Run

Run on QEMU.

```
$ make run
```

(requires `qemu-system-x86_64`)
