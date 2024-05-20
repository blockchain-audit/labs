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
    mapping (address => Borrow) public borrowers;

    constructor () {
        bond = new MyToken();
        Dai = new MyToken();
    }

    function depositDai(uint amountDai) public { 
        Dai.trasferFrom(msg.sender, address(this), amountDai);
        bond.mint(msg.sender, amountDai);
        depositers[msg.sender] = amountDai;
    }

    function withdrawDai(uint amountDai) public {
        require(depositers[msg.sender] >= amountDai, "You dont have enough Dai in the protocol");
        Dai.transfer(msg.sender, amountDai);
        bond.transferFrom(msg.sender, address(this), amountDai);
    }

    function addCollateral(uint amountETH) external payable {
        borrowers[mgs.sender].eth += amountETH;

    }



}