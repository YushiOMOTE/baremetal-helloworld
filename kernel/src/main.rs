#![no_std]
#![no_main]

use bootloader_api::{entry_point, BootInfo};
use log::info;

entry_point!(kernel_main);

fn kernel_main(_info: &'static mut BootInfo) -> ! {
    com_logger::init();

    info!("Hello wold!");

    exit_qemu(QemuExitCode::Success);

    loop {}
}

#[panic_handler]
fn panic(_info: &core::panic::PanicInfo) -> ! {
    loop {}
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
#[repr(u32)]
pub enum QemuExitCode {
    Success = 0x10,
    Failed = 0x11,
}

pub fn exit_qemu(exit_code: QemuExitCode) {
    use x86_64::instructions::port::Port;

    unsafe {
        let mut port = Port::new(0xf4);
        port.write(exit_code as u32);
    }
}
