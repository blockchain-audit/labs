// https://www.cse.unsw.edu.au/~se2011/DafnyDocumentation/Dafny%20-%20Sets.pdf
// https://dafny.org/dafny/OnlineTutorial/ValueTypes

include "util/number.dfy"
include "util/maps.dfy"
include "util/tx.dfy"


import opened Number
import opened Maps
import opened Tx

function get1(m: u160) : (r: u160)
requires m == 32
ensures  r == 35 {
    m + 3
}


method get(m:set<(u160,u256)>) returns (r: (nat,nat))
requires m == {(1,2)}
ensures r == (1,2) {
    var pair :| pair in m;
    var lhs  := pair.0 as nat;
    var rhs  := pair.1 as nat;
    r := (lhs,rhs);
}


ghost function sum(m:set<(u160,u256)>) : nat {
    if m == {} then 0               // stop recursive calls
    else
        var pair :| pair in m;      // selects a tuple 'pair' from 'm' pattern matching
        var rhs  := pair.1 as nat;  // extract and cast the second element from the 'pair'
        rhs + sum(m - {pair})       // recursive call with the updated set m - {pair},
                                    // which removes the selected tuple from the set,
}                                   // and adds the casted value to the result of the recursive call

function sumit(p1:set<(u160,u256)>, p2:set<(u160,u256)>) : (r: u256)
requires p1 == {(1,2), (3,4), (5,6)}
requires p2 == {(7,8), (9,10), (11,12)} {
    //assert sum(p1) == 10;
    3

}
