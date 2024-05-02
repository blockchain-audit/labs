
pragma solidity ^0.8.20;

import "@hack/solidity/staking/staking.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Vm.sol";

contract StakingTest is Test{
uint constant WAD = 10**18;
StakingRewards staking;
address user1 = vm.add(1);
address user2 = vm.add(2);
address user3 = vm.add(3);


}