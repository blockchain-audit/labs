// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.20;


contract Wallet {
    address payable public owner;

    constructor(){
        owner = payable(msg.sender);        
    }

    receive() external payable {}

    function withdraw(uint amount) public {
        owner.transfer(amount);
    }
}
