// SPDX-License-Identifier: MIT
// https://solidity-by-example.org/defi/staking-rewards/
// Code is a stripped down version of Synthetix
pragma solidity ^0.8.20;
import "forge-std/console.sol";
import "forge-std/Test.sol";

import "../../src/Staking/MyToken.sol";
import "../../src/AMM/CP.sol";

contract CPTest is Test{

    MyERC20 token0;
    MyERC20 token1;
    CP cp;
    function setUp() public{
        token0 = new MyERC20(100);
        token1 = new MyERC20(100);
        cp = new CP(address(token0),address(token1));
        token0.approve(address(this),100);
        token0.approve(address(cp),100);
        token1.approve(address(cp),10);
        token0.mint(address(cp),100);
        token1.mint(address(cp),100);

    }
    function testSwap()public{
    
        
        uint amountOut = cp.swap(address(token0),20);
        console.log(token0.balanceOf(address(token0)),"balance of token0");
        console.log(token1.balanceOf(address(token1)),"balance of token1");
        console.log(amountOut);
    }
    function testAddLiquidity()public{
        uint shares;
        //Shimon deposit 5,10
        vm.startPrank(address(1));
        shares=cp.addLiquidity(5,10);
        console.log(shares);
        vm.stopPrank();

        //reuven deposit 15, 30
        vm.startPrank(address(2));
        shares=cp.addLiquidity(15,30);
        console.log(shares);
        console.log(reserve0);
        console.log(reserve1);
        vm.stopPrank();

        //levi deposit 1, 2
        vm.startPrank(address(3));
        shares=cp.addLiquidity(1,2);
        console.log(shares);
        console.log(reserve0);
        console.log(reserve1);
        vm.stopPrank();

        //yaakov swap 5 t0
         vm.startPrank(address(4));
         uint amountOut = cp.swap(address(token1),5);
         console

    }



}