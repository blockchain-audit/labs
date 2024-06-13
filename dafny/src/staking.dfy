include "util/number.dfy"
include "util/maps.dfy"
include "util/tx.dfy"


import opened Number
import opened Maps
import opened Tx


class Staking {
    var balances: mapping<u160, u256>
    var val: u256

    constructor() {
        val := 50;
    }

    method deposit(msg: Transaction) 
    modifies this`balances{
        assume {:axiom} (MAX_U256 as u256 - balances.Get(msg.sender)) >= msg.value;
        balances := balances.Set(msg.sender, balances.Get(msg.sender) + msg.value);
    }
}


method {:test} call () {
    var j := 9;
    var o := new Staking();
    print('\n');
    print(j/5);
    print('\n');
    print(o.val);
    print('\n');
} 
