// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "forge-std/Test.sol";
import "@labs/tokens/MyToken.sol";
import "@labs/lending/Lending.sol";

contract TestLending()public{

    MyToken dai;
    MyTOken bonds;
    Lending lending;
    function setUp()public{
        dai = new MyToken();
        bonds = new MyToken();
        lending = new Lending(bonds,dai);
    }


    function test()public{
        uint s = lending.getLatestPrice();
        console.log(s);
    }
}