// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

import "@hack/staking/myToken.sol";

struct Borrow 
{
    uint eth;
    uint Dai;
}
contract Lending {

    MyToken public bond;
    MyToken public Dai;
    mapping (address => uint) public depositers;

    constructor () {
        bond = new MyToken();
        Dai = new MyToken();
    }

    function depositDai(uint amountDai) public {
        bond.mint(msg.sender, amountDai);

    }



}