/*
@file: main.rs
@desc: use second_mod.rs
@run: rustc main.rs; ./main
*/
mod second_mod;
use second_mod::ClassName;

fn main() {
    let object = ClassName::new(1024);
    object.public_method();
}
