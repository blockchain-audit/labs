// SPDX-License-Identifier: MIT
// https://solidity-by-example.org/defi/staking-rewards/
// Code is a stripped down version of Synthetix
pragma solidity ^0.8.24;

import "../../src/amm/amm1.sol";
import "../../src/tokens/myToken1.sol";
import "../../src/tokens/myToken2.sol";
import "forge-std/console.sol";
import "forge-std/Test.sol";


contract Amm1Test is Test {
    MyToken x;
    MyToken2 y;
    Amm1 amm1;

    function setUp() public {
        x = new MyToken();
        y = new MyToken2();
        // amm1 = new Amm1(address(x),address(y));

        // x.mint(200);
        // y.mint(200);
        // x.approve(address(amm1),200);
        // y.approve(address(amm1),200);
    }

    function testTradeXtoY() public {
        // console.log("balance of test-amm1",x.balanceOf(address(this)));
        // uint256 amountX = 20;
        // uint amountY = amm1.tradeXToY(amountX);
        // assertEq(amountY, 16666666666666666666);
    }
}
