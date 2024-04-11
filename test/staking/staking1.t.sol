pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/staking/staking1.sol";


contract stakeTest is Test {

    Staking1 public stake;

   function setUp() public {
        stake = new Staking1();  
    }
    function testsStaking() public {

        }
}