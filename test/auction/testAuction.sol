// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/auction/auction.sol";
import "@hack/staking/myToken.sol";
import "@hack/tokens/myERC721Token.sol";

contract TestAuction is Test {

    Staking public staking;
    MyToken tokenERC20;
    MyERC721Token tokenERC721;



    function setUp () public {
        tokenERC20 = new MyToken();
        tokenERC721 = new MyERC721Token();
        staking = new Staking(address(tokenERC20));
    }

    function testStartAuction() public {
        tokenERC721._mint(address(this), 123);
    }
}