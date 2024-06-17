fn foo(x: u32, y: u32){
    // ...
}

fn main(){
    let first_arg = 3;
    let second_arg = 4;

    foo(x: first_arg, y: second_arg);
    // foo(y: second_arg, x: first_arg); <- this would failed.
}

// if the name of the variable is the same name as the parameter, we can use a shorter cat.
fn main1() {
    let x = 1;
    let y = 2;

    foo(:x, :y); 
}