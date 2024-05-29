//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.7;

interface Ipool {
    function deposit(address asset, uint256 amount, address onBehalfOf, uint16 referralCode) external;

    function withdraw(address asset, uint256 amount, address to) external;
}
