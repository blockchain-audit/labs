// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "forge-std/Test.sol";
import "@labs/tokens/MyToken.sol";
// import "forge-std/interfaces/IERC20.sol";
import "@labs/lending/Lending.sol";
import "forge-std/console.sol";

contract TestLending {
    // IERC20 dai;
    MyToken bonds;
    Lending lending;

    function setUp() public {
        // dai = new MyToken();
        bonds = new MyToken();
        lending = new Lending(address(bonds), 1500000000000000000);
    }

    function test() public {
        uint256 s = lending.getETHPrice();
        console.log(s);
    }
}