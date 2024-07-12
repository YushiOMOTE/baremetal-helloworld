# A x86 bare-metal hello-world in Rust

[![Actions Status](https://github.com/YushiOMOTE/baremetal-helloworld/workflows/build/badge.svg)](https://github.com/YushiOMOTE/baremetal-helloworld/actions)

A minimum example for x86 bare-metal in Rust. As of 2024/07.

* Builds bootable image on x86 bare-metal.
* Prints hello world on Qemu.

### Setup

Use `nightly` Rust.

```sh
sudo apt install qemu-system

rustup target add x86_64-unknown-none
rustup component add rust-src
rustup component add llvm-tools-preview
```

### Build

```sh
cargo build
```

This builds bootable images for both BIOS (`bios.img`) and UEFI (`uefi.img`).

### Run

Run on BIOS.

```sh
cargo run
```

Run on UEFI.

```sh
USE_UEFI=1 cargo run
```

In both BIOS and UEFI cases, this runs the `kernel` on `qemu-system-x86_64`. When started, `kernel` prints `Hello world!`, then immediately shuts down by hitting the Qemu exit port.
Output goes to `stdout` through serial port. Display is disabled.

Example output is:

```sh
INFO : Framebuffer info: FrameBufferInfo { byte_len: 2764800, width: 1280, height: 720, pixel_format: Bgr, bytes_per_pixel: 3, stride: 1280 }
INFO : 4th Stage
INFO : BiosInfo { stage_4: Region { start: 130000, len: 26600 }, kernel: Region { start: 1000000, len: b3e08 }, ramdisk: Region { start: 10b4000, len: 0 }, config_file: Region { start: 10b4000, len: 0 }, last_used_addr: 10b3fff, framebuffer: BiosFramebufferInfo { region: Region { start: fd000000, len: 2a3000 }, width: 500, height: 2d0, bytes_per_pixel: 3, stride: 500, pixel_format: Bgr }, memory_map_addr: e55c, memory_map_len: 6 }
INFO : BIOS boot
INFO : Elf file loaded at 0x0000000001000000
INFO : virtual_address_offset: 0x8000000000
INFO : Handling Segment: Ph64(ProgramHeader64 { type_: Ok(Load), flags: Flags(4), offset: 0, virtual_addr: 0, physical_addr: 0, file_size: 19fc, mem_size: 19fc, align: 1000 })
INFO : Handling Segment: Ph64(ProgramHeader64 { type_: Ok(Load), flags: Flags(5), offset: 1a00, virtual_addr: 2a00, physical_addr: 2a00, file_size: 5138, mem_size: 5138, align: 1000 })
INFO : Handling Segment: Ph64(ProgramHeader64 { type_: Ok(Load), flags: Flags(6), offset: 6b38, virtual_addr: 8b38, physical_addr: 8b38, file_size: 928, mem_size: 14c8, align: 1000 })
INFO : Mapping bss section
INFO : Handling Segment: Ph64(ProgramHeader64 { type_: Ok(Load), flags: Flags(6), offset: 7460, virtual_addr: a460, physical_addr: a460, file_size: 18, mem_size: 28, align: 1000 })
INFO : Mapping bss section
INFO : Entry point at: 0x8000002d30
INFO : Creating GDT at PhysAddr(0x10d5000)
INFO : Map framebuffer
INFO : Allocate bootinfo
INFO : Create Memory Map
INFO : Create bootinfo
INFO : Jumping to kernel entry point at VirtAddr(0x8000002d30)
    INFO: Hello wold! (kernel, kernel/src/main.rs:12)
```

See the CI results for full setup and execution.
