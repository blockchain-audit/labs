// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

contract Wallet {
    mapping(address => bool) public owners;
    address public mainOwner;
    uint256 public countOwners;

    constructor() {
        mainOwner = msg.sender;
    }

    receive() external payable {}

    function withdraw(uint wad) external isOwner {
        payable (msg.sender).transfer(wad);
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }

    modifier  isOwner() {

        require(owners[msg.sender] == true || mainOwner == msg.sender,"Sender is not one of the owners");
        _;
    }

    function addOwner(address newOwner) external {

        require(msg.sender == mainOwner, "Only mainOwner can add another owner");
        require(countOwners < 3, "There are already 3 owners");
        require(!owners[newOwner], "The owner is already exist");

        countOwners++;
        owners[newOwner] = true;
    }

    function changeOwner(address oldOwner, address newOwner) external {

        require(msg.sender == mainOwner, "Only the main owner can change an owner");
        require(!owners[oldOwner],"Adress of old owner does not exist as an owner");
        require(owners[newOwner],"New owner is already an owner");
        owners[oldOwner] = false;
        owners[newOwner] = true;
    }
 }
