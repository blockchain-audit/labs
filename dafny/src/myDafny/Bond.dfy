include "../util/number.dfy"
include "../util/maps.dfy"
include "../util/tx.dfy"
include "../erc20.dfy"


import opened Number
import opened Maps
import opened Tx


class Bond {
  // a 160-bit unsigned integer that uniquely identifies the address. However,
  // this value is not directly used as the external representation, that is in u256

    const baseRate: u256 := 20_000_000_000_000_000
    const annuRate: u256 := 300_000_000_000_000_000

    var balances:   mapping<u160, u256>
    var collateral: mapping<u160, u256>
    var borrowed:   mapping<u160, u256>


    // add collateral
    method deposit(msg: Transaction) returns (r: Result<()>)
    modifies this`collateral {
        assume {:axiom} (MAX_U256 as u256 - collateral.Get(msg.sender)) >= msg.value;
        collateral := balances.Set(msg.sender, collateral.Get(msg.sender) + msg.value);
        return Ok(());
    }
}