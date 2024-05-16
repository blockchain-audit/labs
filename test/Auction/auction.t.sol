// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/store/store.sol";
import "@hack/Auction/auction.sol";
import "@hack/Auction/MyNft.sol";
import "../../new-project/src/MyToken.sol";

contract AuctionTest is Test {
    Auction public a;
    MyNft public nftT;
    MyToken public tokenT;
    uint256 immutable wad = 1e18;
    address public myUser;

    function setUp() public {
        nftT = new MyNft();
        tokenT = new MyToken();
        a = new Auction(address(nftT), 100, address(tokenT), 1);
        myUser = vm.addr(1);
    }

    function testAddBidder() public {
        uint256 amount = 200;
        vm.startPrank(myUser);
        tokenT.approve(address(a), amount);
        tokenT.mint(address(myUser), amount);
        vm.warp(2 days);
        a.addBid(amount);
        assertEq(a.bidders(myUser), amount);
        vm.stopPrank();
    }

    function testDontAddBidder() public {
        uint256 amount = 50;
        vm.startPrank(myUser);
        tokenT.approve(address(a), amount);
        tokenT.mint(address(myUser), amount);
        vm.warp(2 days);
        vm.expectRevert("The value is less than the initial value");
        a.addBid(amount);
        vm.stopPrank();
    }

    function testRemoveOffer() public {
        uint256 sum1 = 200;
        uint256 sum2 = 300;
        address user1 = vm.addr(1234);
        address user2 = vm.addr(123);
        vm.startPrank(user1);
        a.addBid(sum1);
        vm.stopPrank();
        vm.startPrank(user2);
        a.addBid(sum2);
        vm.stopPrank();
        vm.startPrank(user1);
        vm.warp(2 days);
        a.removeOffer();
        assertEq(a.bidders(user1), 0);
        vm.stopPrank();
    }
}
