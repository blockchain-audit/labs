// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// import "forge-std/Test.sol";
// import "forge-std/console.sol";
// import "foundry-huff/HuffDeployer.sol";

// import "../../src/decentralizedExchange/CP.sol";
// import "../../src/decentralizedExchange/ERC20.sol";

// contract CPTest{

//     uint constant WAD = 10 ** 18;

//     CP public cp;

//     MyERC20 tokenA;
//     MyERC20 tokenB;

//     uint256 initialBalanceA = 50000;
//     uint256 initialBalanceB = 50000;

//     function setUp() public {

//         tokenA = new MyERC20(10000000000000);
//         tokenB = new MyERC20(10000000000000);
        
//         cp = new CP(address(tokenA), address(tokenB));

//         tokenA.mint(address(cp), 50000);
//         tokenB.mint(address(cp), 50000);
//     }

//     function testSwap() public {
//         // swap A to B
//         uint256 amountA = 7000;

//         // 1
//         console.log("before trading");
//         console.log("balanceA", cp.reserve0());
//         console.log("balanceB", cp.reserve1());
//         tokenA.approve(address(cp), amountA);
//         cp.swap(address(tokenA), amountA);

//         console.log("after trading");
//         console.log("balanceA", cp.reserve0());
//         console.log("balanceB", cp.reserve1());

//         // 2
//         amountA = 10000;
//         console.log("before trading");
//         console.log("balanceA", cp.reserve0());
//         console.log("balanceB", cp.reserve1());
//         tokenA.approve(address(cp), amountA);
//         cp.swap(address(tokenA), amountA);

//         console.log("after trading");
//         console.log("balanceA", cp.reserve0());
//         console.log("balanceB", cp.reserve1());

//         // Trade B to A
//         uint256 amountB = 2000;
//         console.log("before trading");
//         console.log("balanceA", cp.reserve0());
//         console.log("balanceB", cp.reserve1());
//         tokenB.approve(address(cp), amountB);
//         cp.swap(address(tokenB), amountB);

//         console.log("after trading");
//         console.log("balanceA", cp.reserve0());
//         console.log("balanceB", cp.reserve1());

//         // Add liquidity
//         // 1
//         amountA = 5000;
//         amountB = 3091;
//         // 39314 / 63592 = 0.618
//         // amountB = 5000 * 0.618

//         tokenA.approve(address(cp), amountA);
//         tokenB.approve(address(cp), amountB);

//         cp.addLiquidity(amountA, amountB);

//         console.log("balanceA", cp.reserve0());
//         console.log("balanceB", cp.reserve1());

//         // assertEq(amountB, oldB * WAD / oldA * amountA / WAD, "False");

//         // 2
//         // address user = vm.addr(1);
//         // vm.startPrank(user);
//         // amountA = 5000;
//         // amountB = dex.priceA(amountA);

//         // tokenA.approve(address(dex), amountA);
//         // tokenB.approve(address(dex), amountB);

//         // (balanceA, balanceB) = dex.getBalances();
//         // oldA = balanceA;
//         // oldB = balanceB;

//         // dex.addLiquidity(amountA, amountB);

//         // (balanceA, balanceB) = dex.getBalances();

//         // console.log("balanceA", balanceA);
//         // console.log("balanceB", balanceB);
//         // vm.stopPrank();

//         // Trade A to B
//         // amountB = 289;

//         // console.log("before trading");
//         // console.log("balanceA", cp.reserve0());
//         // console.log("balanceB", cp.reserve1());
//         // tokenB.approve(address(cp), amountB);
//         // cp.swap(address(tokenB), amountB);

//         // console.log("after trading");
//         // console.log("balanceA", cp.reserve0());
//         // console.log("balanceB", cp.reserve1());

//         // Remove liquidity
//         // 1
//         uint256 amount = 289;
//         cp.removeLiquidity(amount);

//         console.log("balanceA", cp.reserve0());
//         console.log("balanceB", cp.reserve1());

//         //2
//         // vm.startPrank(user);
//         // (maxA, maxB) = dex.getMaxLiquidityToRemove();
//         // console.log("maxA", maxA);
//         // console.log("maxB", maxB);

//         // (balanceA, balanceB) = dex.getBalances();
//         // oldA = balanceA;
//         // oldB = balanceB;

//         // dex.removeLiquidity(maxA, maxB);

//         // (balanceA, balanceB) = dex.getBalances();

//         // console.log("balanceA", balanceA);
//         // console.log("balanceB", balanceB);
//         // vm.stopPrank();

//     }

//     // function testAddLiquidity() public {
//     //     uint256 amountA = 2000;
//     //     uint256 amountB = dex.priceA(amountA);

//     //     tokenA.approve(address(dex), amountA);
//     //     tokenB.approve(address(dex), amountB);

//     //     dex.addLiquidity(amountA, amountB);

//     //     console.log("amountB", amountB);
//     //     console.log("dex.k() / amountA", dex.k() / tokenA.balanceOf(address(this)));

//     //     // assertEq(dex.k() / amountA, amountB, "False");

//     // }

//     // function removeLiquidity() public {
//     //     amountA = 5000;
//     //     amountB = dex.priceA(amountA);

//     //     tokenA.approve(address(dex), amountA);
//     //     tokenB.approve(address(dex), amountB);

//     //     (balanceA, balanceB) = dex.getBalances();
//     //     uint256 oldA = balanceA;
//     //     uint256 oldB = balanceB;

//     //     dex.addLiquidity(amountA, amountB);

//     //     (balanceA, balanceB) = dex.getBalances();

//     //     console.log("balanceA", balanceA);
//     //     console.log("balanceB", balanceB);
//     // }
// }