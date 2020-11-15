.PHONY: setup build run clean

qemu ?= qemu-system-x86_64

target-dir = target/helloworld/release
bootloader-target-dir = target/x86_64-bootloader/release

kernel = $(target-dir)/helloworld
bootloader = $(bootloader-target-dir)/bootloader
bootloader-bin = $(bootloader-target-dir)/bootloader.bin
bootloader-dir = bootloader

setup:
	git submodule update --init
	cargo install cargo-xbuild

build: $(bootloader-bin)

run: build
	$(qemu) -drive format=raw,file=$(bootloader-dir)/$(bootloader-bin)

clean:
	cargo xbuild clean
	rm -rf	$(target-dir) $(bootloader-target-dir)

$(kernel): helloworld.json Cargo.toml $(wildcard src/**/*)
	cargo xbuild --release --target $<

$(bootloader): export KERNEL = ../$(kernel)
$(bootloader): export KERNEL_MANIFEST = ../Cargo.toml
$(bootloader): $(kernel)
	cd $(bootloader-dir); cargo xbuild --features binary --release

$(bootloader-bin): $(bootloader)
	cd $(bootloader-dir); cargo objcopy -- -I elf64-x86-64 -O binary --binary-architecture=i386:x86-64 $< $@
