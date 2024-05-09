// SPDX-License-Identifier: MIT
// https://solidity-by-example.org/defi/staking-rewards/
// Code is a stripped down version of Synthetix
pragma solidity ^0.8.24;
import "../../src/AMM/cpAmm.sol";
import "../../src/staking/MyToken.sol";
import "../../src/staking/MyToken2.sol";
import "forge-std/console.sol";

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
        // x.approve(address(cpAmm),200);
        // y.approve(address(cpAmm),200);
    }

    function testAddLiquidity() public{
        cpAmm.addLiquidity(100, 100);
        assertEq(x.balanceOf(address(cpAmm)), 100);
    }

    function testSwap() public{

    }
}