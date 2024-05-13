// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "forge-std/Test.sol";
import "@labs/tokens/MyNFT.sol";
import "@labs/tokens/MyToken.sol";
import "@labs/auction/Auction.sol";

contract TestAuction is Test {
    MyNFT NFTtoken;
    MyToken token;
    Auction auction;
    uint256 wad = 1e18;
    address user1;
    address user2;

    function setUp() public {
        NFTtoken = new MyNFT();
        token = new MyToken();
        auction = new Auction();
        user1 = vm.addr(1);
        user2 = vm.addr(2);
    }

    function testStart() public {
        start();
        NFTtoken.mint(address(this), 2);
        NFTtoken.approve(address(auction), 2);
        vm.expectRevert("already there is auction");
        auction.start(address(NFTtoken), 2, address(token), 100 * wad, 7 days);
    }

    function testBid() public {
        start();
        vm.startPrank(user1);
        bid(200 * wad);
        vm.stopPrank();
        assertEq(auction.maxBidder(), user1);
        assertEq(auction.maxPrice(), 200 * wad);
        assertEq(token.balanceOf(user1), 0);
    }

    function testBidNotBigger() public {
        start();
        vm.startPrank(user1);
        bid(200 * wad);
        vm.stopPrank();
        vm.startPrank(user2);
        token.mint(100 * wad);
        token.approve(address(auction), 100 * wad);
        vm.expectRevert("amount <= max");
        auction.bid(100 * wad);
    }

    function testWinner() public {
        start();
        vm.startPrank(user1);
        bid(200 * wad);
        vm.stopPrank();
        vm.warp(7 days + 2);
        auction.winner();
        assertEq(NFTtoken.ownerOf(1), user1);
        assertEq(token.balanceOf(address(this)), 200 * wad);
    }

    function bid(uint256 amount) private {
        token.mint(amount);
        token.approve(address(auction), amount);
        auction.bid(amount);
    }

    function start() public {
        NFTtoken.mint(address(this), 1);
        NFTtoken.approve(address(auction), 1);
        auction.start(address(NFTtoken), 1, address(token), 100 * wad, 7 days);
    }
}
