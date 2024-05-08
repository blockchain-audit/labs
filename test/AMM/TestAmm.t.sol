// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.2;

// import "@labs/staking/MyToken.sol";
// import "@labs/AMM/Amm.sol";
// import "forge-std/Test.sol";

// contract TestAmm is Test {
//     MyToken tokenA;
//     MyToken tokenB;
//     Amm amm;
//     uint256 wad = 1e18;

//     function setUp() public {
//         tokenA = new MyToken();
//         tokenB = new MyToken();
//         amm = new Amm(address(tokenA), address(tokenB));
//     }

//     function testCalcCount() public {
//         console.log(amm.calcCount(60 * wad, 50 * wad, 10 * wad, 2) / wad);
//         assertEq(amm.calcCount(60 * wad, 50 * wad, 10 * wad, 1), 8333333333333333330);
//         assertEq(amm.calcCount(60 * wad, 50 * wad, 10 * wad, 2), 12000000000000000000);
//     }
// }
