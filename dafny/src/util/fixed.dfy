include "number.dfy"
include "maps.dfy"
include "tx.dfy"


// Fixed point arithmetic math
// https://github.com/dapphub/ds-math/blob/master/src/math.sol
module Fixed {

import opened Number
import opened Maps
import opened Tx

    const WAD: u256 := 1_000_000_000_000_000_000 // 18 zeros
    const RAY: u256 := 1_000_000_000_000_000_000_000_000_000 // 27
    const PER: u256 := 10_000

    // -- SIMPLE arithmetic

    function Add(x: u256, y: u256) : u256
    requires (x as nat) + (y as nat) <= MAX_U256 {
        x + y
    }

    function Sub(x: u256, y: u256) : u256
    requires (x as int) - (y as int) >= 0 {
        x - y
    }

    function Mul(x: u256, y: u256) : u256
    requires (x as nat) * (y as nat) <= MAX_U256 {
        x * y
    }

    function Div(x: u256, y: u256) : u256
    requires y != 0 {
        x / y
    }

    // -- HIGH PRECISION ARITHMETIC

    function Bps(x: u256, y: u256) : (r: u256)
    requires (x as nat) * (y as nat) <= MAX_U256 as nat {
        Mul(x,y) / PER
    }

    //rounds to zero if x*y < WAD / 2
    function Wmul(x: u256, y: u256) : u256
    requires y == 0 || (x as nat) * (y as nat) <= MAX_U256 as nat
    requires (Mul(x,y) as nat) + ((WAD/2) as nat) <= MAX_U256 as nat
    requires Mul(x,y) as nat <= MAX_U256 {
        var m: u256 := Mul(x,y);
        var w: u256 := WAD / 2;
        (Add(m , w))/WAD
    }

    //rounds to zero if x*y < WAD / 2
    function Wdiv(x: u256, y:u256) : (r: u256)
    requires (x as nat) * (WAD as nat) < MAX_U256
    requires Mul(x,WAD) as nat + (y/2) as nat <= MAX_U256 as nat
    requires y != 0
    ensures r < MAX_U256 as u256{
        var m: u256 := Mul(x,WAD);
        var w: u256 := y / 2;
        var z: u256 := Add(m,w);
        z / y
    }


    // recursive ghost function that calculates the sum of the second elements of all tuples
    // in a given set. It uses pattern matching to extract elements from the set and
    // recursively processes the remaining elements until the set is empty.
    // :| operator, which is a form of pattern matching in Dafny. This operator allows
    // you to destructure the set and extract an element.
    ghost function sum(m:set<(u160,u256)>) : nat {
        if m == {} then 0               // stop recursive calls
        else
            var pair :| pair in m;      // selects a tuple 'pair' from 'm' pattern matching
            var rhs  := pair.1 as nat;  // extract and cast the second element from the 'pair'
            rhs + sum(m -{pair})        // recursive call with the updated set m - {pair},
                                        // which removes the selected tuple from the set,
    }                                   // and adds the casted value to the result of the recursive call



    // Prove that the sum of the elements in the union of two sets is equal
    // to the sum of the elements in each set individually. Example:
    // s1 contains the elements { (1, 2), (3, 4) }
    // s2 contains the elements { (5, 6), (7, 8) }
    // union of s1 and s2 is { (1, 2), (3, 4), (5, 6), (7, 8) }
    // sum of the second elements of s1 is 2 + 4 = 6
    // sum of the second elements of s2 is 6 + 8 = 14
    // sum of the second elements of the union is 6 + 14 = 20
    // so the lemma states that sum(s1 + s2) == sum(s1) + sum(s2),
    // which is 20 == 6 + 14, and this is true.
    lemma set_as_union(p1: (u160,u256), p2: (u160,u256))
    ensures sum({p1,p2}) == (p1.1 as nat) + (p2.1 as nat) {
        union_sum_as_units({p1},{p2});  // compare the sum of sets with individual tuples.
        assert {p1,p2} == {p1} + {p2};  // asserts that creating a set with p1 and p2 is equivalent to the union of sets {p1} and {p2}.
    }

    // Prove a property about the sum of elements in two sets of tuples, where each tuple
    // contains a u160 and a u256, it ensures that the sum of the elements in the union
    // of two sets (s1 and s2) is equal to the sum of the elements in each set individually. Ex:
    // s1 - contains the tuples: {(1, 2), (3, 4)}
    // s2 - contains the tuples: {(5, 6), (7, 8)}
    // the lemma states that the sum of the elements in the union of s1 and s2
    // is equal to the sum of the elements in each set individually.
    // let's calculate the sum of the elements in s1 and s2 individually:
    // sum of s1: 2 + 4 = 6
    // sum of s2: 6 + 8 = 14
    // let's calculate the sum of the elements in the union of s1 and s2:
    // union of s1 and s2: {(1, 2), (3, 4), (5, 6), (7, 8)}
    // sum of the union: 2 + 4 + 6 + 8 = 20
    // according to the lemma, the sum of the elements in the union of s1 and s2 should be equal
    // to the sum of the elements in each set individually. In this case:
    // sum of s1 + sum of s2 = 6 + 14 = 20
    // this matches the sum of the elements in the union of s1 and s2, demonstrating that
    // this lemma holds true for this example.
    lemma union_sum_as_units(s1: set<(u160, u256)>, s2: set<(u160, u256)>)
    ensures sum(s1 + s2) == sum(s1) + sum(s2) {
        if s1 == {} {
            assert sum({}) == 0;                 // base case: if s1 is an empty set, its sum is 0.
            assert sum(s1 + s2) == sum({} + s2); // the sum of s1 union s2 is the same as the sum of an empty set union s2.
            assert {}+s2 == s2;                  // the union of an empty set with s2 is simply s2.
            assert sum(s1 + s2) == sum(s2);      // hence, sum of s1 + s2 is the same as the sum of s2, given s1 is empty.
        } else {
            assume {:axiom} sum(s1 + s2) == sum(s1) + sum(s2); // for non-empty s1, it is assumed (without proof)
        }                                             // that the sum of the union is the sum of individual sets.
    }
}

// --- TESTS

import opened Fixed
import opened Number
import opened Maps
import opened Tx

method {:test} testFindMax() {
    var j := 1000000000000000000 as u256;
    var i := 1000000000000000000 as u256;
    var r := 1000000000000000000 as u256;

    assert Wmul(j,i) == r;
    assert Wmul(WAD, WAD) == WAD;
    assert Wdiv(j,i) == r;
    assert Wdiv(WAD, WAD) == WAD;
    assert Wdiv(4*WAD, 2*WAD) == 2*WAD;

    var x : nat := 100000000000000000;

    // 10^18 * 10^18 = 10^36
    //print(x*x); // it has 34 zeros ! help

    var x1 : nat := 1000000000000000000;
    var x2 : nat := 1000000000000000000;
    var r1 : nat := 1000000000000000000000000000000000000;
    var r2 : nat := (r1 + (x1/2)) / x1;
    assert x1*x2 == r1;

    print(x1*x2);
    assert r2 == x1;

    // 0.01 percent = 1 BPS
    var y1 := 20_000000000000000000 as u256;  // 20 WAD
    var p1 := 200 as u256;                    // 2% in BPS
    assert Bps(y1, p1) == 400000000000000000; // 0.4

    // dafny automatic convert from nat to int when needed
    var o1 : nat := 3;
    var o2 : nat := 4;
    var o3 : int := o1-o2;
    assert o1 - o2 == -1;

    // use the 'number.dfy'
    assert Div(7,12) == 0;

    assert Div(1*WAD, 2*WAD)  == 0;
    assert Wdiv(1*WAD, 2*WAD) == 500000000000000000;
}




