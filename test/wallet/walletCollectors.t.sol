// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

//import {Test} from "forge-std/Test.sol";
//import {console} from "forge-std/console.sol";
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
}

receive() external payable{}

function test_changeLimit () public{
 //   uint limit = 5;
 // Collectors.changeLimit(limit);
}

function test_addCollector() public{
Collectors.addCollector(address(0x123));
}

/*function testFail_addCollector() public{

}

function test_removeCollector() public{

}

function testFail_removeCollector() public{

}

function test_changeCollector() public{

}

function testFail_changeCollector() public{

}

function test_withdraw() public{

}

function testFail_withdraw() public{

}

function test_getBalance() public{

}
*/
}
