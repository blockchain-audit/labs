// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.20;

///@title Wallet
contract Wallet {

    address payable public owner;

    constructor() {
        owner = payable(msg.sender); // 'msg.sender' is sender of current call
    }

receive() external payable {} 

    function withdraw(uint amount) external  {
        require(msg.sender==owner,"WALLET-not-owner");
        require(msg.sender.balance>=amount,"There is no enough money to withdraw");
        payable(msg.sender).transfer(amount);
    }

    function getBalance() external view returns(uint){
        return  address(this).balance;
    }
}
