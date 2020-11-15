.PHONY: setup build run clean

qemu ?= qemu-system-x86_64

target-dir = target/helloworld/release
bootloader-target-dir = target/x86_64-bootloader/release

kernel = $(target-dir)/helloworld
bootloader = $(bootloader-target-dir)/bootloader
bootloader-bin = $(bootloader-target-dir)/bootloader.bin
bootloader-dir = bootloader

qemu-opt ?=
qemu-drive-opt ?= -drive format=raw,file=$(bootloader-dir)/$(bootloader-bin)

pwd ?= $(shell pwd)

tests-dir = $(pwd)/tests

hash ?= md5sum

setup:
	git submodule update --init
	cargo install cargo-xbuild
	cargo install cargo-binutils
	rustup component add rust-src
	rustup component add llvm-tools-preview

build: $(bootloader-bin)

run: build
	$(qemu) $(qemu-opt) $(qemu-drive-opt)

test:
	$(qemu) -qmp tcp:localhost:4444,server,nowait $(qemu-drive-opt) &
	sleep 3
	python tests/check.py $(tests-dir)/dump.ppm
	rm tests/*.ppm
	unzip tests/expect.zip
	diff $(tests-dir)/dump.ppm $(tests-dir)/expect.ppm

$(kernel): helloworld.json Cargo.toml $(wildcard src/**/*)
	cargo xbuild --release --target $<

$(bootloader): export KERNEL = ../$(kernel)
$(bootloader): export KERNEL_MANIFEST = ../Cargo.toml
$(bootloader): $(kernel)
	cd $(bootloader-dir); cargo xbuild --features binary --release

$(bootloader-bin): $(bootloader)
	cd $(bootloader-dir); rust-objcopy -I elf64-x86-64 -O binary --binary-architecture=i386:x86-64 $< $@
