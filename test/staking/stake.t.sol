//  // SPDX-License-Identifier: Unlicen
// pragma solidity ^0.8.24;

// import "../../src/staking/stake.sol";
// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
// import "foundry-huff/HuffDeployer.sol";
// import "forge-std/Test.sol";
// import "forge-std/console.sol";
// import "@hack/store/store.sol";
// import "/home/user/myToken/new-project/script/myToken.sol";

// contract TestStake is Test {
//     Staking public stake;
//     MyToken public myCoin;
//     uint256 wad = 10 ** 18;

//     // initialization
//     function setUp() public {
//         myCoin = new MyToken();
//         stake = new Staking(address(myCoin));
//     } 

//     function testDeposit() public {
//         uint256 sum = 100 * wad;
//         myCoin.mint(address(this), sum);
//         uint256 balanceBefore = stake.amount();
//         uint256 initialTtoalBalance = stake.getBalance();
//         myCoin.approve(address(stake),sum);
//         stake.deposit(sum);
//         uint256 finalTtoalBalance = stake.getBalance();
//         uint256 finalUserBalance = stake.amount();
//         assertEq(finalTtoalBalance, initialTtoalBalance + sum, "Contract balance not updated correctly");
//         assertEq(finalUserBalance, balanceBefore + sum, "Contract balance not updated correctly");
//     }

//     function testNotWithdraw() public {

//         uint256 sum = 200 * wad;
//         myCoin.mint(address(this), sum);
//         myCoin.approve(address(stake),sum);
//         stake.deposit(sum);
//         uint256 balanceBefore = stake.amount();
//         vm.expectRevert(); //Not a week has passed
//         stake.withdraw(sum);
//     }

//     function testWithdraw() public {
//         console.log("testWithdraw");
//         uint256 sum = 100 * wad;
//         myCoin.mint(address(this), sum);
//         myCoin.approve(address(stake),sum);
//         stake.deposit(sum);
//         vm.warp(block.timestamp + 7 days );
//         uint256 balanceBefore = stake.amount(); //200
//         stake.withdraw(sum);
//         uint256 finalUserBalance = stake.amount(); //100
//         console.log("finamsglUserBalance", finalUserBalance);
//         assertEq(finalUserBalance, balanceBefore - sum, "d");
//     }

// }

