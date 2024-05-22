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

    constructor (address _dai, address _bond) {
        bond = MyToken(_bond);
        dai = MyToken(_dai);
    }











    

    function depositDai(uint amountDai) public { 
        dai.transferFrom(msg.sender, address(this), amountDai);
        bond.mint(msg.sender, amountDai);
        depositers[msg.sender] = amountDai;
    }

    function withdrawDai(uint amountDai) public {
        require(depositers[msg.sender] >= amountDai, "You dont have enough Dai in the protocol");
        dai.transfer(msg.sender, amountDai);
        bond.transferFrom(msg.sender, address(this), amountDai);
    }

    function addSupply(uint amountETH) external payable {
        borrowers[msg.sender].eth += amountETH;
        dai.mint(address(msg.sender), amountETH);
        borrowers[msg.sender].dai += amountETH;
    }



}