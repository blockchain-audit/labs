include "../util/number.dfy"
include "../util/maps.dfy"
include "../util/tx.dfy"
include "../erc20/erc20.dfy"


import opened Number
import opened Maps
import opened Tx


class Bond {
  // a 160-bit unsigned integer that uniquely identifies the address. However,
  // this value is not directly used as the external representation, that is in u256
    var usdc: ERC20
    var bond: ERC20

    const baseRate: u256 := 20_000_000_000_000_000    // 0.02 [wad]
    const annuRate: u256 := 300_000_000_000_000_000   // 0.3  [wad]

    // totals
    var borrow:  u256
    var lends:   u256
    var reserve: u256

    var balances:   mapping<u160, u256>
    var collateral: mapping<u160, u256>
    var borrowed:   mapping<u160, u256>

    constructor() {
        usdc := new ERC20();
        bond := new ERC20();
        borrow := 0;
        lends  := 0;
    }

    // supply collateral for lending
    method supply(msg: Transaction, amount: u256) returns (r: Result<()>)
    modifies this`collateral
    requires amount as nat <= MAX_U256 - collateral.Get(msg.sender) as nat {
        collateral := balances.Set(msg.sender, collateral.Get(msg.sender) + amount);
        return Ok(());
    }


    method remove(msg: Transaction, amount: u256) returns (r: Result<()>)
    modifies this`collateral
    requires amount as nat <= collateral.Get(msg.sender) as nat {
        collateral := balances.Set(msg.sender, collateral.Get(msg.sender) - amount);
        return Ok(());
    }


}
