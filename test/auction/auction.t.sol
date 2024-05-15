pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../../lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";
import "@hack/auction/auction.sol";
import "@hack/tokens/token3.sol";

contract auctionTest is Test{
    Token3 public token;
    Auction public auction;
    address adr1=address(1);

    function setUp() public{
    token = new Token3("nft" ,"nnn");
    auction = new Auction(address(token));
    console.log(msg.sender);
    console.log(address(this));
    token.mint(address(this), 10000000);
    token.mint(address(this), 123);

    // token.mint(address(this), 10000000);
    }

    function testStartAuction() public{
        // vm.startPrank(adr1);
        console.log(token.ownerOf(10000000));
        // token.approve(address(auction) , 10000000);
        // auction.startAuction(10000000, 222235);
        token.approve(address(auction) , 123);
        auction.startAuction(123, 222235);
        (   
           address seller,
           uint tokenId,
           bool started,
           bool ended,
           uint256 endAt,
           address highestBidder,
           uint256 highestBid 
        ) = auction.auctions(123);
        console.log(seller);

        assert(seller == address(this));
        assert(tokenId == 123);
        assert(started == true);
        assert(ended == false);
        assert(endAt )


         
      
    }

    




     

}