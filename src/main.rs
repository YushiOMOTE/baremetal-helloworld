#![no_std]
#![no_main]

#[no_mangle]
pub extern "C" fn _start() -> ! {
    let vga = 0xb8000 as *mut u8;

    for (i, b) in b"Hello world".iter().enumerate() {
        unsafe {
            *vga.offset(i as isize * 2) = *b;
            *vga.offset(i as isize * 2 + 1) = 0x0f;
        }
    }

    loop {}
}

#[panic_handler]
fn panic(__info: &core::panic::PanicInfo) -> ! {
    loop {}
}
