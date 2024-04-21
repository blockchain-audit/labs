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

function setUp() public {
   c = new Collectors();
}
function test_changeLimit(){
    uint limit = 5;
  Collectors.changeLimit(limit);
}

function test_addCollector(){

}

function testFail_addCollector(){

}

function test_removeCollector(){

}

function testFail_removeCollector(){

}

function test_changeCollector(){

}

function testFail_changeCollector(){

}

function test_withdraw(){

}

function testFail_withdraw(){

}

function test_getBalance(){

}

}
