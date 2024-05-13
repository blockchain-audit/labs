// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "foundry-huff/HuffDeployer.sol";

import "../../src/decentralizedExchange/decentralizedExchange.sol";
import "../../src/decentralizedExchange/ERC20.sol";

contract DEXTest{

    uint constant WAD = 10 ** 18;

    DEX public dex;

    MyERC20 tokenA;
    MyERC20 tokenB;

    uint256 initialBalanceA = 50000;
    uint256 initialBalanceB = 50000;

    function setUp() public {

        tokenA = new MyERC20(10000000000000);
        tokenB = new MyERC20(10000000000000);
        
        dex = new DEX(address(tokenA), address(tokenB));

        tokenA.approve(address(dex), initialBalanceA);
        tokenB.approve(address(dex), initialBalanceB);

        dex.initialize(initialBalanceA, initialBalanceB); 
    }

    function testTrade() public {
        // trade A to B
        uint256 amountA = 7000;
        uint256 amountB = dex.calculateBForATrade(amountA);

        (uint256 balanceA, uint256 balanceB) = dex.getBalances();

        // 1
        console.log("before trading");
        console.log("balanceA", balanceA);
        console.log("balanceB", balanceB);
        tokenA.approve(address(dex), amountA);
        dex.tradeAToB(amountA);

        console.log("after trading");
        (balanceA, balanceB) = dex.getBalances();
        console.log("balanceA", balanceA);
        console.log("balanceB", balanceB);

        // 2
        tokenA.approve(address(dex), 10000);
        dex.tradeAToB(10000);
        console.log("after trading");
        (balanceA, balanceB) = dex.getBalances();
        console.log("balanceA", balanceA);
        console.log("balanceB", balanceB);

        // Trade B to A
        tokenB.approve(address(dex), 2000);
        dex.tradeBToA(2000);
        console.log("after trading");
        (balanceA, balanceB) = dex.getBalances();
        console.log("balanceA", balanceA);
        console.log("balanceB", balanceB);

        // Add liquidity
        // 1
        amountA = 5000;
        amountB = dex.priceA(amountA);

        tokenA.approve(address(dex), amountA);
        tokenB.approve(address(dex), amountB);

        (balanceA, balanceB) = dex.getBalances();
        uint256 oldA = balanceA;
        uint256 oldB = balanceB;

        dex.addLiquidity(amountA, amountB);

        (balanceA, balanceB) = dex.getBalances();

        console.log("balanceA", balanceA);
        console.log("balanceB", balanceB);

        // assertEq(amountB, oldB * WAD / oldA * amountA / WAD, "False");

        // 2
        // address user = vm.addr(1);
        // vm.startPrank(user);
        // amountA = 5000;
        // amountB = dex.priceA(amountA);

        // tokenA.approve(address(dex), amountA);
        // tokenB.approve(address(dex), amountB);

        // (balanceA, balanceB) = dex.getBalances();
        // oldA = balanceA;
        // oldB = balanceB;

        // dex.addLiquidity(amountA, amountB);

        // (balanceA, balanceB) = dex.getBalances();

        // console.log("balanceA", balanceA);
        // console.log("balanceB", balanceB);
        // vm.stopPrank();

        // Trade A to B
        tokenB.approve(address(dex), 2000);
        dex.tradeBToA(2000);
        console.log("after trading");
        (balanceA, balanceB) = dex.getBalances();
        console.log("balanceA", balanceA);
        console.log("balanceB", balanceB);

        // Remove liquidity
        // 1
        (uint256 maxA, uint256 maxB) = dex.getMaxLiquidityToRemove();
        console.log("maxA", maxA);
        console.log("maxB", maxB);

        (balanceA, balanceB) = dex.getBalances();
        oldA = balanceA;
        oldB = balanceB;

        dex.removeLiquidity(maxA, maxB);

        (balanceA, balanceB) = dex.getBalances();

        console.log("balanceA", balanceA);
        console.log("balanceB", balanceB);

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