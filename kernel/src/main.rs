#![no_std]
#![no_main]

use bootloader_api::{entry_point, BootInfo};
use log::info;

entry_point!(kernel_main);

fn kernel_main(_info: &'static mut BootInfo) -> ! {
    com_logger::init();

    info!("Hello wold!");

    loop {}
}

#[panic_handler]
fn panic(_info: &core::panic::PanicInfo) -> ! {
    loop {}
}
