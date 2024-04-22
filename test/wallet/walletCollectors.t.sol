// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

//import {Test} from "forge-std/Test.sol";
//import {console} from "forge-std/console.sol";
import "forge-std/StdAssertions.sol";

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "forge-std/Vm.sol";
import "@hack/wallet/walletCollectors.sol";

contract CollectorsTest is Test{
   Collectors public c;
   address public sender;

function setUp() public {
   c = new Collectors();
   sender = msg.sender;
   payable(address(c)).transfer(200);
}

receive() external payable{}

function test_changeLimit () public{
   uint limit = 5;
   c.changeLimit(limit);
   assertEq.equal(c.limitCollectors, 5, "Limit collectors should be update to 5");
   uint currentLimit = c.limitCollectors;
   assertEq(currentLimit == limit, "Change limit function not working correctly.");
}

function test_addCollector() public{
    address newCollector = address(0x123);
    c.addCollector(newCollector);
    bool isCollectorAdded = c.collectors[newCollector];
    assertEq(isCollectorAdded == true, "Add collector function not working correctly.");
}

//function testFail_addCollector() public{

//}

function test_removeCollector() public{
    address collectorToRemove = address(0x123);
    c.removeCollector(collectorToRemove);
    bool isCollectorRemoved = c.collectors[collectorToRemove];
    assertEq(isCollectorRemoved == false, "Remove collector function not working correctly.");
}

//function testFail_removeCollector() public{

//}

function test_changeCollector() public{
    address collectorToChange = address(0x123);
    address newCollector = address(0x456);
    c.changeCollector(collectorToChange, newCollector);
    bool isCollectorChanged = c.collectors[newCollector];
    assertEq(isCollectorChanged == true,"Change collector function not working correctly.");
}

//function testFail_changeCollector() public{

//}

function test_withdraw() public{
uint amount = 1 ether;
uint initialBalance = address(this).balance;
c.withdraw(amoun);
uint fianlBalance = address(c).balance;
assertEq(fianlBalance == initialBalance - amount, "Withdrawal amount incorrect.");
}

//function testFail_withdraw() public{

//}

function test_getBalance() public{
    assertEq(address(c).balance == c.getBalance, "Contract balance does not match expected balance.");
    //address(c) is same address(this)
}

}