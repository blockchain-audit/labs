// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.20;

///@title Wallet
contract Wallet {
    address payable public owner;
    uint256 public count = 0;
    bool public isGabay;

    mapping(address => bool) public gabaim;

    constructor() {
        owner = payable(msg.sender); // 'msg.sender' is sender of current call
    }

    receive() external payable {}

    function addGabay(address gabay) public isOwner {
        require(count < 3, "too many Gabaim");
        require(gabaim[gabay] == false,"this is already a gabay");
        gabaim[gabay] = true;
        count++;
    }

    modifier isOwner() {
        require(msg.sender == owner, "Caller is not owner");
        _;
    }

    modifier isAllowed() {
        require(
            msg.sender == owner || gabaim[msg.sender] == true,
            "Caller is not allowed"
        );
        _;
    }

    function withdraw(uint256 amount) external isAllowed {
        require(
            msg.sender.balance >= amount,
            "There is no enough money to withdraw"
        );
        payable(msg.sender).transfer(amount);
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function deleteGabay(address gabay) external isAllowed {
        require(gabaim[gabay] == true, "this is not a gabay");
        gabaim[gabay] = false;
        count--;
    }
}
