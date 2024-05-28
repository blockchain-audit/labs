include "util/number.dfy"
include "util/maps.dfy"
include "util/tx.dfy"
 module Math {
    import opened Number
    import opened Maps
    import opened Tx
    const WAD: u256 := 1000000000000000000
    const RAY: u256 := 1000000000000000000000000000
    const EXP_SCALE: u256 := WAD
    const HALF_EXP_SCALE: u256 := EXP_SCALE / 2
    function Add(x: u256, y: u256) : u256
    requires (x as nat) + (y as nat) <= MAX_U256 as nat{
        x + y
    }
    function Sub(x: u256, y: u256) : u256
    requires (x as nat) - (y as nat) >= 0 as nat {
        x - y
    }
    function Mul(x: u256, y: u256) : u256
    requires (x as nat) * (y as nat) <= MAX_U256 as nat
    {
        x * y
    }
    function Wmul(x: u256, y: u256) : u256
    requires y == 0 || (x as nat) * (y as nat) <= MAX_U256 as nat
    requires Mul(x,y) as nat <= MAX_U256 {
        var m: u256 := Mul(x,y);
        var w: u256 := WAD / 2;
        assume (m as nat) + (w as nat) <= MAX_U256 as nat;
        Add(m , w)/ WAD
    }

function tryMul(a:u256, b:u256) : (bool ,u256)
requires (a as nat) * (b as nat) <= MAX_U256 as nat
   {  
   var c: u256 := a * b;
   if a == 0 then (true, 0) else
   if c / a != b then (false, 0)
   else (true , c)
}

function tryDiv (a:u256, b:u256) : (bool ,u256)
{
    if b == 0 then (false,0)
    else (true , a/b)

}


    // function getExp(num: u256, denom: u256) : u256 
    // {
    //     var s: bool := false;
    //     var n: u256 := 0;
        
        
    // }

 }