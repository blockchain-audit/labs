// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Wallet {
    address public owner;

    // Constructor sets the owner of the contract
    constructor() {
        owner = msg.sender;
    }

    //1

    // Event emitted when ETH is received
    event Received(address indexed sender, uint256 amount);

    // Function to receive ETH
    receive() external payable {
        // Emit an event indicating the amount of ETH received and who sent it
        emit Received(msg.sender, msg.value);
    }

    //2
    function abc(uint256 amount)public{
        require(msg.sender == owner,"WALLET-not-owner");
        require(address(this).balance >= amount);
        payable(owner).transfer(amount);

    }
    //  event Output(string message, uint256 value);


    //3

     function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    
}

