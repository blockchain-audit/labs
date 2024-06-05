// This function doesn't return anything.
fn main(){
    let x = 3;
}

// This funtions return an u32. 
fn inc (x: u32) -> u32 {
    x + 1
}


// Note that in cairo, functions always return a value. 
// when the funtions has no return a value, 
// it is common to return the uint type(()).