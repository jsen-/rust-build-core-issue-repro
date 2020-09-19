#![no_std]
#![no_main]

#[no_mangle]
fn main() {}

#[panic_handler]
fn panic(_info: &core::panic::PanicInfo) -> ! {
     loop {}
}