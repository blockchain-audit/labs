pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../../lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";
import "@hack/auction/auction.sol";
import "@hack/tokens/token3.sol";

contract auctionTest is Test{
    Token3 public token;
    Auction public auction;

    function setUp() public{
    token = new Token3("nft" ,"nnn");
    auction = new Auction();
    console.log(msg.sender);
    console.log(address(this));
    token.mint(address(this), 10000000);
    // token.mint(address(this), 10000000);
    }

    function testStartAuction() public{
        console.log(token.ownerOf(10000000));
        auction.startAuction(10000000,222235);

    }




     

}