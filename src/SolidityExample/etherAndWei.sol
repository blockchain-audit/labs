// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract etherUnite {
    uint256 public oneWei = 1 wei;
    bool public isOwner = (oneWei == 1);
    
    uint256 public oneGwei = 1 gwei;
    bool public isOneGwei = (oneGwei == 1e9);

    uint256 public oneEther = 1 ether;
    bool public isOneEther = (oneEther == 1e18);
}