// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/console.sol";

contract CollectorsWallet {
    address payable public owner;

    mapping(address => uint256) public collectors;

    constructor() {
        owner = payable(msg.sender);
        collectors[0xaC4E320Ed1235F185Bc6AC8856Ec7FEA7fF0310d] = 1;
        collectors[0x7c0FA5571c4A1A67FD21Ed9209674868cC8dc86b] = 1;
        collectors[0x7a3b914a1f0bD991BAf826F4fE9a47Bb9880d25f] = 1;
    }

    modifier onlyOwner() {
        console.log(owner);
        require(owner == msg.sender, "You are not the owner");
        _;
    }

    receive() external payable {}

    // function getOwner() returns (address) {
    //     return owner;
    // }

    function withdraw(uint256 wad) external {
        require(owner == msg.sender || collectors[msg.sender] == 1, "You are not allowed");
        require(address(this).balance >= wad, "Not Enough Money");
        payable(msg.sender).transfer(wad);
    }

    function updateCollectors(address oldCollector, address newCollector) external onlyOwner {
        require(collectors[oldCollector] == 1, "Old Collector not exist"); // check if collector exist in my hash
        require(collectors[newCollector] == 0, "A Collector exist"); // check if collector exist in my hash
        collectors[newCollector] = 1;
        collectors[oldCollector] = 0;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
