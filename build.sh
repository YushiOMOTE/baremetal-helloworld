#!/bin/bash

cargo xbuild --release --target helloworld.json
cd bootloader
KERNEL=../target/helloworld/release/helloworld KERNEL_MANIFEST=../Cargo.toml cargo xbuild --features binary --release
cargo objcopy -- -I elf64-x86-64 -O binary --binary-architecture=i386:x86-64   target/x86_64-bootloader/release/bootloader target/x86_64-bootloader/release/bootloader.bin
qemu-system-x86_64 -drive format=raw,file=target/x86_64-bootloader/release/bootloader.bin
