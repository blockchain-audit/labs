// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "forge-std/console.sol";

contract Distribute {


    address[] public usersAddresses;

    constructor() {
    }

    receive() external payable {}

    function addUser(address newUser) public {
        usersAddresses.push(newUser);
    }

    function distributeTotalAmount(uint256 totalAmount) public payable{
        uint256 amount = totalAmount / usersAddresses.length;
        console.log("amount", amount);
        for (uint i = 0; i < usersAddresses.length; i++) {
            payable(usersAddresses[i]).transfer(amount);
        }       
    }

    function distributeAmount(uint256 amount) public payable{
        for (uint i = 0; i < usersAddresses.length; i++) {
            payable(usersAddresses[i]).transfer(amount);
        }       
    }

}
