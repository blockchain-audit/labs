use debug::PrintTrait;

fn main_one() {
   let x; felt252 = 3618502788666131213697322783095070105623107215331596699973092056135872020480;
   let y: felt252 = 1;

   assert(x + y == 0, 'If you add to the max num it returns 0');
}