// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.15;

import "forge-std/console.sol";

contract Divide {
    address[] public addresses;

    function divide() public payable {
        uint256 amountToOne = msg.value / addresses.length;
        for (uint256 i = 0; i < addresses.length; i++) {
            payable(addresses[i]).transfer(amountToOne);
        }
    }

    function addAddress(address adrs) public {
        addresses.push(adrs);
    }
}
