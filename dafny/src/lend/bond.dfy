include "../util/number.dfy"
include "../util/maps.dfy"
include "../util/tx.dfy"
include "../util/fixed.dfy"
include "../erc20/erc20.dfy"


import opened Number
import opened Maps
import opened Tx
import opened Fixed


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


    // U = borrows / (Cash + Borrows)
    function Utilization(u: u256, b: u256, c: u256) : (r: u256)
    requires (c as nat) + (b as nat) <= MAX_U256
    requires b as int <= MAX_U160 as int
    requires Add(c, b) != 0 {
        var t: u256 := Add(c, b);
        Wdiv(b, t)
    }

    // Borrow Interest Rate = 2.5% + Util * 20%
    //function Interest

    // supply collateral for lending
    method Supply(msg: Transaction, amount: u256) returns (r: Result<()>)
    modifies this`collateral
    requires amount as nat <= MAX_U256 - collateral.Get(msg.sender) as nat {
        collateral := balances.Set(msg.sender,
                      collateral.Get(msg.sender) + amount);
        return Ok(());
    }


    method Remove(msg: Transaction, amount: u256) returns (r: Result<()>)
    modifies this`collateral
    requires amount as nat <= collateral.Get(msg.sender) as nat {
        collateral := balances.Set(msg.sender,
                      collateral.Get(msg.sender) - amount);
        return Ok(());
    }


}
