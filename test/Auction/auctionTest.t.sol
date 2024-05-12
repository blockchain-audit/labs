// SPDX-License-Identifier: MIT
// https://solidity-by-example.org/defi/staking-rewards/
// Code is a stripped down version of Synthetix
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../../src/Auction/auction.sol";

contract auctionTest is Test{

    Auction auction;
    MyNFT nftToken;
    address seller;
    address bidder1;
    address bidder2;

    function setUp() public {
        auction = new Auction();
        nftToken = new MyNFT();

        seller = vm.addr(1);
        bidder1 = vm.addr(2);
        bidder2 = vm.addr(3);

        testInitAuction();
    }

    function testInitAuction() public {
        vm.startPrank(seller);
        uint idToken = 123;
        nftToken.mint(seller, idToken);
        uint prePrice = 100;
        uint duration = 7 days;
        nftToken.setApprovalForAll(address(auction), true);
        auction.initAuction(duration, nftToken, idToken, prePrice);
        assertEq(nftToken.ownerOf(idToken),address(auction));  // nft moved to auction
        vm.stopPrank();
    }

    

    function testAddBid() public {
        vm.startPrank(bidder1);
        uint price = 300;
        vm.deal(bidder1, price);

        auction.addBid(price, seller);
        
        vm.stopPrank();
    }

    function testNotAddBid() public {
        vm.startPrank(bidder1);
        uint price = 300;
        vm.deal(bidder1, price);

        vm.expectRevert();
        auction.addBid(price, address(this)); // seller is not exist
        
        vm.stopPrank();
    }

    function testAdd2Bidds() public {
        
        vm.startPrank(bidder1);
        uint price = 300;
        vm.deal(bidder1, price);

        auction.addBid(price, seller);
        
        vm.stopPrank();
        
        vm.startPrank(bidder2);
        price = 500;
        vm.deal(bidder1, price);

        auction.addBid(price, seller);
        
        vm.stopPrank();
    }

     function testNotAdd2Bidds() public {
        
        vm.startPrank(bidder1);
        uint price = 300;
        vm.deal(bidder1, price);

        auction.addBid(price, seller);
        
        vm.stopPrank();
        
        vm.startPrank(bidder2);
        price = 100;
        vm.deal(bidder1, price);

        vm.expectRevert();
        auction.addBid(price, seller);
        
        vm.stopPrank();
    }


    function testNotRemoveBid() public {
        vm.startPrank(bidder1);
        auction.removeBid(address(this));
        vm.stopPrank();
    }

    function testRemoveBid() public {
        vm.startPrank(bidder1);
        auction.removeBid(address(seller));
        vm.stopPrank();
    }
}