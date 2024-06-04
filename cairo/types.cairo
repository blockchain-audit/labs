fn main() {
    let logical: bool = true;
    let a: u64 = 1; 
    let b = 5_u32; 
    let default_integer = 7; 
    let mut inferred_type = 12;
    inferred_type = 4294967296_u64;
    let mut mutable = 12_u32; 
    mutable = 21;
    let tuple = (1_u32, true, 10000000_u64);
    let composed_tuple = (tuple, 1_u8, (true, false));
    let (a, b, c) = tuple;
    assert(a == 1_u32, 'tuple unpack');

    let num_decimal = 171717_u32;
    let num_hex = 0x29ec5_u32;
    let num_octal = 0o517305;
    let num_binary = 0b101001111011000101;
    assert(num_decimal == num_hex, 'numeric literal cmp');
    assert(num_decimal == num_octal, 'numeric literal cmp');
    assert(num_decimal == num_binary, 'numeric literal cmp');
}