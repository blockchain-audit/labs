// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/interfaces/IERC721.sol";
import "forge-std/console.sol";

contract AuctionContract {
//your code is complete!!!!!
    // Struct to represent an auction
    struct Auction {
        address seller;
        uint256 tokenId;
        bool started;
        uint256 endAt; 
        address highestBidder;
        uint256 highestBid;
    }

    IERC721 public tokenNFT;

    uint256 public auctionCounter;

    // Mapping from auction ID to Auction struct
    mapping(uint256 => Auction) public auctions;

    event startAuctionEvent(address, uint256);
    event placeBidEvent(address, uint256);
    event withdrawBidEvent(address, uint256);
    event endAuctionEvent(address, uint256, uint256);

    constructor(address _tokenNFT) {
        tokenNFT = IERC721(_tokenNFT);
    }
    
    function getAuction(uint256 auctionId) public view returns(Auction memory) {
        return auctions[auctionId];
    }

    modifier OnlySeller(uint256 auctionId) {
        require(msg.sender == auctions[auctionId].seller, "Only the seller can set the auction");
        _;
    }
    
    function setEndAt(uint256 auctionId, uint256 endAt) public OnlySeller(auctionId){
        require(auctions[auctionId].endAt < endAt);
        auctions[auctionId].endAt = endAt;
    }

    function startAuction(uint256 tokenId, uint256 endAt) public payable returns (uint256){
        require(tokenNFT.ownerOf(tokenId) == msg.sender, "Not token owner");

        auctions[auctionCounter].seller = msg.sender;
        auctions[auctionCounter].tokenId = tokenId;
        auctions[auctionCounter].started = true;
        auctions[auctionCounter].endAt = endAt;

        // Transfer the token to the contract
        tokenNFT.transferFrom(msg.sender, address(this), tokenId);

        placeBid(auctionCounter);

        auctionCounter++;

        emit startAuctionEvent(msg.sender, auctionCounter);
        
        return auctionCounter - 1;
    }

    // Assuming that the person who activates the function sends a value that will be sent from him to the smart contract
    function placeBid(uint256 auctionId) public payable {
        require(auctions[auctionId].started, "This auction is no longer active");
        require(block.timestamp < auctions[auctionId].endAt, "This auction is no longer active");
        require(msg.value > 0 && msg.value > auctions[auctionId].highestBid, "Your bid must be greater than the highest bid");

        console.log("Previous highest bidder:", auctions[auctionId].highestBidder);
        console.log("Previous highest bid:", auctions[auctionId].highestBid);
        console.log("Contract balance before transfer:", address(this).balance);

        if (auctions[auctionId].highestBidder != address(0)) {
            // Transfer funds back to the previous highest bidder
            payable(auctions[auctionId].highestBidder).transfer(auctions[auctionId].highestBid);
        }

        console.log("Contract balance after transfer:", address(this).balance);

        // Update highest bidder and bid amount
        auctions[auctionId].highestBidder = msg.sender;
        auctions[auctionId].highestBid = msg.value;

        emit placeBidEvent(msg.sender, msg.value);
    }   

    function endAuction(uint256 auctionId) public {
        require(auctions[auctionId].endAt < block.timestamp, "The auction is still active");
        require(auctions[auctionId].started == true, "The auction is already closed");

        // Transfer token to the highest bidder
        tokenNFT.transferFrom(address(this), auctions[auctionId].highestBidder, auctions[auctionId].tokenId);

        // Transfer bid amount to the seller
        uint256 amount = auctions[auctionId].highestBid;
        payable(auctions[auctionId].seller).transfer(amount);

        // Mark auction as ended
        auctions[auctionId].started = false;

        emit endAuctionEvent(auctions[auctionId].highestBidder, auctionId, amount);
    }

}