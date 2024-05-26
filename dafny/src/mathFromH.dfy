
include "util/number.dfy"
include "util/maps.dfy"
include "util/tx.dfy"



// Fixed point arithmetic math
// https://github.com/dapphub/ds-math/blob/master/src/math.sol
module Fixed {

import opened Number
import opened Maps
import opened Tx

    const WAD: u256 := 1000000000000000000;
    const RAY: u256 := 1000000000000000000000000000;
    const a : nat := 10;

    function Add(x: u256, y: u256) : u256 
        requires (x as nat) + (y as nat) <= MAX_U256 as nat{
        x + y
    }

    function Sub(x: u256, y: u256) : u256
    requires (x as nat) - (y as nat) >= 0 as nat {
        x - y
    }

    function Mul(x: u256, y: u256) : u256
    requires y == 0 || (x as nat) * (y as nat) <= MAX_U256 as nat {
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

}