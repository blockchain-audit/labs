// SPDX-License-Identifier: MIT
// https://solidity-by-example.org/defi/staking-rewards/
// Code is a stripped down version of Synthetix
pragma solidity ^0.8.24;
import "../../src/AMM/cpAmm.sol";
import "../../src/staking/MyToken.sol";
import "../../src/staking/MyToken2.sol";
import "forge-std/console.sol";

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";

contract cpAmmTest is Test{
    
    MyToken x;
    MyToken2 y;
    CpAmm cpAmm;
    
    function setUp() public{
        x = new MyToken();
        y = new MyToken2();
        cpAmm = new CpAmm(address(x),address(y)); 

        x.mint(200); 
        y.mint(200);
        
        x.approve(address(cpAmm),200);
        y.approve(address(cpAmm),200);
    }

    function testAddLiquidity() public{
        uint myShares = cpAmm.addLiquidity(100, 100);
        console.log(myShares,"myShares");
        assertEq(cpAmm.totalSupply(), myShares);
        assertEq(x.balanceOf(address(cpAmm)), 100);
        assertEq(y.balanceOf(address(cpAmm)), 100);
        assertEq(cpAmm.balances(address(this)), myShares);

        vm.expectRevert();
        myShares = cpAmm.addLiquidity(0, 100);
    }

    function testSwap() public{
        
    }

      function testRemoveLiquidity() public{

    }

}