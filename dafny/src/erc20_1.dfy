include "./util/number.dfy"
include "./util/maps.dfy"
include "./util/tx.dfy"


import opened Number
import opened Maps
import opened Tx


class ERC20_1 {
  // a 160-bit unsigned integer that uniquely identifies the address. However,
  // this value is not directly used as the external representation, that is in u256
  var balances:  mapping<u160,u256>
  var allowance: mapping<u160, mapping<u160,u256>>

  constructor() {
    balances := Map(map[], 0);
    allowance := Map(map[], Map(map[],0));
  }

  method fallback(msg: Transaction) returns (r: Result<()>) 
  modifies this`balances {
        r := deposit(msg);
    }

  method deposit(msg: Transaction) returns (r: Result<()>)
  modifies this`balances {
    assume {:axiom} (MAX_U256 as u256 - balances.Get(msg.sender)) >= msg.value;
    balances := balances.Set(msg.sender, balances.Get(msg.sender) + msg.value);
    return Ok(());
  }

  // allow users to withdraw tokens into their account, updating their balances.
  method withdraw(msg: Transaction, wad: u256) returns (r: Result<()>) 
  modifies this`balances{
    if balances.Get(msg.sender) < wad { return Revert; }
    balances := balances.Set(msg.sender, balances.Get(msg.sender) - wad);

    var executed := Tx.transfer(msg.sender, wad);
    if executed == Revert { return Revert; }

    return Ok(());
  }

  method approve(msg: Transaction, guy: u160, wad: u256) returns (r: Result<bool>)
  modifies this`allowance {
    var a := allowance.Get(msg.sender).Set(guy, wad);
    allowance := allowance.Set(msg.sender, a);
    return Ok(true);
  }

  method transfer(msg: Transaction, dst: u160, wad: u256) returns (r: Result<bool>) 
  modifies this`allowance, this`balances {  // non-payable
    r := transferFrom(msg, msg.sender, dst, wad);
  }

  method transferFrom(msg: Transaction, src: u160, dst: u160, wad: u256) returns (r: Result<bool>) 
    modifies this`balances, this`allowance{
    if balances.Get(src) < wad { return Revert; }
    assume {:axiom} (old(balances).Get(dst) as nat) + (wad as nat) <= MAX_U256;
    if src != msg.sender && allowance.Get(src).Get(msg.sender) != (MAX_U256 as u256) {
      if allowance.Get(src).Get(msg.sender) < wad { return Revert; }
      var a := allowance.Get(src);
      allowance := allowance.Set(src,a.Set(msg.sender, a.Get(msg.sender) -wad));
    }

    // accounting
    balances := balances.Set(src, balances.Get(src) - wad);
    balances := balances.Set(dst, balances.Get(dst) + wad);

    r := Result<bool>.Ok(true);
  }

}