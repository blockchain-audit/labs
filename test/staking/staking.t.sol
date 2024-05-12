// //SPDX-License-Identifier: Unlicense
// pragma solidity ^0.8.15;

// import "forge-std/Test.sol";
// import "forge-std/console.sol";
// import "@hack/staking/staking.sol";
// import "../../new-project/src/MyToken.sol";

// contract StakingRewardsTest is Test {
//     StakingRewards public s;
//     MyToken public token;
//     address public user = vm.addr(1);

//     function setUp() public {
//         token=new MyToken();
//         s=new StakingRewards(address(token));
//      }
//      function testDeposit(uint256 _amount) public{

//      }
//       function testDepositNotUser() public{
//         vm.startPrank(0x562b99aCA39C6e94d93F483E074BBaf5789c87Cd);
//         token.mint(0x562b99aCA39C6e94d93F483E074BBaf5789c87Cd,10000);
//         s.deposit(100);
//         vm.stopPrank();
//         vm.assertEq();

//      }
//      function testDepositDoesntMakeSense() public{

//      }
//      function testWithdraw() public{

//      }

//      function testWithdrawNotUser() public{

//      }
//      function testWithdrawNotEnoughDays() public{

//      }
// }
