

fn foo(x: u8, y: u8){
    x + 1;
    y + 1;
}

fn main_one(){
    let first_arg = 3;
    let second_arg = 4;
    foo(x: first_arg, y: second_arg);
}

fn main_twe(){
    let x = 5;
    let y = 6;
    foo(:x , :y);
}


