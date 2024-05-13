// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/console.sol";

/// @title MultiWallet

contract MultiWallet {
    address payable public chairman;

    address payable[] public owners;

    uint256 public index = 0;

    constructor() {
        chairman = payable(msg.sender);
        owners.push(payable(0x0));
        owners.push(payable(0x0));
        owners.push(payable(0x0));
    }

    /// @notice Get the chairman address
    function getChairman() external view returns (address) {
        return chairman;
    }

    /// @notice Get the owners addresses
    function getOwners() external view returns (address payable[] memory) {
        return owners;
    }

    modifier isOwner() {
        require(
            (msg.sender == owners[0]) ||
                (msg.sender == owners[1]) ||
                (msg.sender == owners[2]) ||
                (msg.sender == chairman),
            "Only the owner allowed to do this"
        );
        _;
    }

    modifier isChairman() {
        require(chairman == msg.sender, "Only the chairman allowed to do this");
        _;
    }

    /// @notice add new owner
    function insertOwner(address newOwner) public isChairman {
        //require(owners.length < 3, "Only three owners allowed");
        require(index < 3, "Only three owners allowed");
        //owners.push(payable(newOwner));
        owners[index] = payable(newOwner);
        index = index + 1;
    }

    /// @notice replace exist owner by new owner
    function replaceOwner(
        address oldOwner,
        address newOwner
    ) public isChairman {
        require((owners[0] == oldOwner) || (owners[1] == oldOwner) || (owners[2] == oldOwner), "Owner not exist");
        if (owners[0] == oldOwner) owners[0] = payable(newOwner);
        else if (owners[1] == oldOwner) owners[1] = payable(newOwner);
        else if (owners[2] == oldOwner) owners[2] = payable(newOwner);
    }

    function removeOwner(address owner) public isChairman {
        require((owners[0] == owner) || (owners[1] == owner) || (owners[2] == owner), "Owner not exist");
        if (owners[0] == owner) owners[0] = payable(0x0);
        else if (owners[1] == payable(owner)) owners[1] = payable(0x0);
        else if (owners[2] == payable(owner)) owners[2] = payable(0x0);
    }

    /// @notice receive ETH to the contract address
    /// built-in function
    receive() external payable {}

    /// @notice withdraw ETH from the contract address to the owner wallet
    function withdraw(uint256 amountWithdraw) public isOwner {
        require(
            address(this).balance >= amountWithdraw,
            "The amount to withdraw should be less than your current balance"
        );

        // transfer Ether from the contract to the owner
        payable(msg.sender).transfer(amountWithdraw);
    }

    /// @notice get the balance of the contract
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
