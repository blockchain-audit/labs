// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../../src/exercises/staking_pool.sol";

contract TestStaking is Test {
    Staking_pool  staking_pool;
    MyToken my_token;
    uint wad=10**18;
    function setUp()public{
        my_token=new MyToken();
        staking_pool=new Staking_pool(address(my_token));
        // i mint to this contrct for he can deposit 
        //שינתי את הכתובת בכל המינט 
        my_token.mint(50*wad,address(this));

    }

    function testwhenDeposit() public {

        uint256 deposit = 50*wad;
        uint256 t=my_token.balanceOf(address(staking_pool));
        uint256 stakeBefore=t;
        //של ורק אחכ הוא יכול לבצע את deposit להשתמש בstaking_pool מאשרת לחוזה של 
        // whenDepositפונקצית staking_pool את הפונקציה שנמצאת בחוזה של 
        my_token.approve(address(staking_pool), deposit);
        staking_pool.whenDeposit(deposit);  
        // בודק אם היתרה של החוזה הנוכחי שווה למס הטוקנים שהנפקתי מינוס הטוקנים שהפקדתי בחוזה אחר 

        assertEq(my_token.balanceOf(address(staking_pool)), stakeBefore+ deposit);
    }          
    function testWithDrawBig()public{
        uint withdraw=10**7*wad;
        vm.expectRevert("cant withdraw more then exsist");
        staking_pool.withDraw(withdraw);
    } 
     function test_not_allowed_WithDraw()public{
        uint withdraw=50*wad;
        //deposit
       testwhenDeposit();
        vm.warp(((block.timestamp+(3 days)) /86400)+1);
        vm.expectRevert("still not over 7 days");
        staking_pool.withDraw(withdraw);
    }   
     function test_allowed_WithDraw()public{
        uint withdraw=50*wad;
        vm.warp(1);

        //deposit
       testwhenDeposit();
        vm.warp(1+7 days);
        staking_pool.withDraw(withdraw);
        assertEq(my_token.balanceOf(address(this)), 60*wad + withdraw);

    } 
    function testMint()public{
        my_token.mint(100,msg.sender);
        assertEq(my_token.balanceOf(address(this)), 100);
    }
}