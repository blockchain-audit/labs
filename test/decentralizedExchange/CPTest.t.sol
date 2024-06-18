// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "foundry-huff/HuffDeployer.sol";

import "../../src/decentralizedExchange/CP.sol";
import "../../src/decentralizedExchange/ERC20.sol";

contract CPNewTest is Test{

    uint constant WAD = 10 ** 18;

    CP public cp;

    MyERC20 tokenA;
    MyERC20 tokenB;

    uint256 initialBalanceA = 0;
    uint256 initialBalanceB = 0;

    function setUp() public {

        tokenA = new MyERC20(10000000000000);
        tokenB = new MyERC20(10000000000000);
        
        cp = new CP(address(tokenA), address(tokenB));

        tokenA.mint(address(cp), initialBalanceA);
        tokenB.mint(address(cp), initialBalanceB);
    }

    function testSwap() public {
        
        // first deposit
        address user1 = vm.addr(1);
        vm.startPrank(user1);
        tokenA.mint(address(user1), 100);
        tokenB.mint(address(user1), 100);

        uint256 amountA = 5;
        uint256 amountB = 10;

        tokenA.approve(address(cp), amountA);
        tokenB.approve(address(cp), amountB);

        cp.addLiquidity(amountA, amountB);

        console.log("first deposit");
        console.log("user1", user1);
        console.log("balanceA", cp.reserve0());
        console.log("balanceB", cp.reserve1());
        console.log("-----------------");

        vm.stopPrank();

        // second deposit
        address user2 = vm.addr(2);
        vm.startPrank(user2);
        tokenA.mint(address(user2), 100);
        tokenB.mint(address(user2), 100);

        amountA = 15;
        amountB = 30;

        tokenA.approve(address(cp), amountA);
        tokenB.approve(address(cp), amountB);

        cp.addLiquidity(amountA, amountB);

        console.log("second deposit");
        console.log("user2", user2);
        console.log("balanceA", cp.reserve0());
        console.log("balanceB", cp.reserve1());
        console.log("-----------------");

        vm.stopPrank();

        // third deposit
        address user3 = vm.addr(3);
        vm.startPrank(user3);
        tokenA.mint(address(user3), 100);
        tokenB.mint(address(user3), 100);

        amountA = 1;
        amountB = 2;

        tokenA.approve(address(cp), amountA);
        tokenB.approve(address(cp), amountB);

        cp.addLiquidity(amountA, amountB);

        console.log("third deposit");
        console.log("user3", user3);
        console.log("balanceA", cp.reserve0());
        console.log("balanceB", cp.reserve1());
        console.log("-----------------");

        vm.stopPrank();

        // swap A to B
        address user4 = vm.addr(4);
        vm.startPrank(user4);
        tokenA.mint(address(user4), 100);

        amountA = 5;
        tokenA.approve(address(cp), amountA);
        cp.swap(address(tokenA), amountA);

        console.log("swap A to B");
        console.log("user4", user4);
        console.log("balanceA", cp.reserve0());
        console.log("balanceB", cp.reserve1());

        vm.stopPrank();

        // // 2
        // amountA = 10000;
        // console.log("before trading");
        // console.log("balanceA", cp.reserve0());
        // console.log("balanceB", cp.reserve1());
        // tokenA.approve(address(cp), amountA);
        // cp.swap(address(tokenA), amountA);

        // console.log("after trading");
        // console.log("balanceA", cp.reserve0());
        // console.log("balanceB", cp.reserve1());

        // // Trade B to A
        // uint256 amountB = 2000;
        // console.log("before trading");
        // console.log("balanceA", cp.reserve0());
        // console.log("balanceB", cp.reserve1());
        // tokenB.approve(address(cp), amountB);
        // cp.swap(address(tokenB), amountB);

        // console.log("after trading");
        // console.log("balanceA", cp.reserve0());
        // console.log("balanceB", cp.reserve1());

        // // Add liquidity
        // // 1
        // amountA = 5000;
        // amountB = 3091;
        // // 39314 / 63592 = 0.618
        // // amountB = 5000 * 0.618

        // tokenA.approve(address(cp), amountA);
        // tokenB.approve(address(cp), amountB);

        // cp.addLiquidity(amountA, amountB);

        // console.log("balanceA", cp.reserve0());
        // console.log("balanceB", cp.reserve1());

        // // assertEq(amountB, oldB * WAD / oldA * amountA / WAD, "False");

        // // 2
        // // address user = vm.addr(1);
        // // vm.startPrank(user);
        // // amountA = 5000;
        // // amountB = dex.priceA(amountA);

        // // tokenA.approve(address(dex), amountA);
        // // tokenB.approve(address(dex), amountB);

        // // (balanceA, balanceB) = dex.getBalances();
        // // oldA = balanceA;
        // // oldB = balanceB;

        // // dex.addLiquidity(amountA, amountB);

        // // (balanceA, balanceB) = dex.getBalances();

        // // console.log("balanceA", balanceA);
        // // console.log("balanceB", balanceB);
        // // vm.stopPrank();

        // // Trade A to B
        // // amountB = 289;

        // // console.log("before trading");
        // // console.log("balanceA", cp.reserve0());
        // // console.log("balanceB", cp.reserve1());
        // // tokenB.approve(address(cp), amountB);
        // // cp.swap(address(tokenB), amountB);

        // // console.log("after trading");
        // // console.log("balanceA", cp.reserve0());
        // // console.log("balanceB", cp.reserve1());

        // // Remove liquidity
        // // 1
        // uint256 amount = 289;
        // cp.removeLiquidity(amount);

        // console.log("balanceA", cp.reserve0());
        // console.log("balanceB", cp.reserve1());

        //2
        // vm.startPrank(user);
        // (maxA, maxB) = dex.getMaxLiquidityToRemove();
        // console.log("maxA", maxA);
        // console.log("maxB", maxB);

        // (balanceA, balanceB) = dex.getBalances();
        // oldA = balanceA;
        // oldB = balanceB;

        // dex.removeLiquidity(maxA, maxB);

        // (balanceA, balanceB) = dex.getBalances();

        // console.log("balanceA", balanceA);
        // console.log("balanceB", balanceB);
        // vm.stopPrank();

    }

    // function testAddLiquidity() public {
    //     uint256 amountA = 2000;
    //     uint256 amountB = dex.priceA(amountA);

    //     tokenA.approve(address(dex), amountA);
    //     tokenB.approve(address(dex), amountB);

    //     dex.addLiquidity(amountA, amountB);

    //     console.log("amountB", amountB);
    //     console.log("dex.k() / amountA", dex.k() / tokenA.balanceOf(address(this)));

    //     // assertEq(dex.k() / amountA, amountB, "False");

    // }

    // function removeLiquidity() public {
    //     amountA = 5000;
    //     amountB = dex.priceA(amountA);

    //     tokenA.approve(address(dex), amountA);
    //     tokenB.approve(address(dex), amountB);

    //     (balanceA, balanceB) = dex.getBalances();
    //     uint256 oldA = balanceA;
    //     uint256 oldB = balanceB;

    //     dex.addLiquidity(amountA, amountB);

    //     (balanceA, balanceB) = dex.getBalances();

    //     console.log("balanceA", balanceA);
    //     console.log("balanceB", balanceB);
    // }
}