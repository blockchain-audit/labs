// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/exercises/staking_pool.sol";

contract TestStaking is Test {
    Staking_pool  staking_pool;
    MyToken my_token;
    uint wad=10**18;
    function setUp()public{
        my_token=new MyToken();
        staking_pool=new Staking_pool(address(my_token));
        // my_token.mint((10**6)*wad);

    }

    function testwhenDeposit() public {

        uint256 deposit = 50;
        // my_token.mint(10**6);
        //של ורק אחכ הוא יכול לבצע את deposit להשתמש בstaking_pool מאשרת לחוזה של 
        // whenDepositפונקצית staking_pool את הפונקציה שנמצאת בחוזה של 
        my_token.approve(address(staking_pool), deposit);
        staking_pool.whenDeposit(deposit);  
        // בודק אם היתרה של החוזה הנוכחי שווה למס הטוקנים שהנפקתי מינוס הטוקנים שהפקדתי בחוזה אחר 
        assertEq(my_token.balanceOf(address(this)), 10**6 - deposit);
    }          
    // function testWithDrawBig()public{
    //     uint withdraw=70*wad;
    //     vm.expectRevert("cant withdraw more then exsist");
    //     staking_pool.withDraw(withdraw);
    // } 
     function testWithDraw()public{
        uint withdraw=50*wad;
        staking_pool.withDraw(withdraw);

      //  assertEq(my_token.balanceOf(address(this)), 60*wad + withdraw);
    } 
    function testMint()public{
        my_token.mint(100);
        assertEq(my_token.balanceOf(address(this)), 100);
    }
}