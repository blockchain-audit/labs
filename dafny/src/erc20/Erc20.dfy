include "../util/number.dfy"
include "../util/maps.dfy"
include "../util/tx.dfy"
include "../erc20.dfy"

import opened Number
import opened Maps
import opened Tx
// import opened ERC20

class testERC20{

var erc20: ERC20;

constructor(){
    erc20 := new ERC20();
}

method transfer(msg:Transaction,receiver:u160,amount: u256) 
modifies erc20
requires erc20.balances.Get(msg.sender) >= amount
ensures ((old(erc20.balances.Get(msg.sender)) - amount) == erc20.balances.Get(msg.sender)) {
    // var r:=9;
    // r := Result<bool>.Ok(true);
    //   var r := 
    var r:=erc20.transfer(msg,receiver,amount);
}
}
