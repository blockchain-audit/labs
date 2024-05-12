// SPDX-License-Identifier: MIT
// https://solidity-by-example.org/defi/staking-rewards/
// Code is a stripped down version of Synthetix
pragma solidity ^0.8.24;

import "oz-contracts/token/ERC721/IERC721.sol";

contract Auction{

    struct Seller{
        IERC721 NFTToken;
        uint tokenId;
        uint startDate;
        uint endAt;        
        bool started;
    }

    struct Bidder{
        address bidAddr;
        uint price;
    }

    struct BiddersPerAuction{
        Bidder prevBidder;
        Bidder currBidder;
    }

    mapping(address => Seller) public sellers;
    mapping(address => BiddersPerAuction) public auctions;

    event start(uint startDate, uint endAt);
    constructor() {
        
    }

    receive() external payable {}

    function initAuction(uint duration, IERC721 nft, uint tokenId, uint prePrice) public {
        Seller memory seller;
        seller.started = true;
        seller.startDate = block.timestamp;
        seller.endAt =  block.timestamp + duration;
        seller.NFTToken = nft;
        seller.tokenId = tokenId;
        seller.NFTToken.transferFrom(msg.sender, address(this), seller.tokenId);
        sellers[msg.sender] = seller; // new seller
        auctions[msg.sender].currBidder.bidAddr = msg.sender; // new auction
        auctions[msg.sender].currBidder.price = prePrice;
        emit start(seller.startDate, seller.endAt);
    }

    function addBid(uint price, address sellerAddr) external {
        require(sellers[sellerAddr].tokenId != 0, "incorrect address of seller"); // seller is exist
        require(price > auctions[sellerAddr].currBidder.price, "price is low");
        auctions[sellerAddr].prevBidder = auctions[sellerAddr].currBidder;
        auctions[sellerAddr].currBidder.bidAddr = msg.sender;
        auctions[sellerAddr].currBidder.price = price; 
        // payable(address(this)).transfer(msg.sender, price);
    }

    function removeBid(address sellerAddr) external{
        require(sellers[sellerAddr].tokenId != 0, "incorrect address of seller"); // seller is exist
        require(auctions[sellerAddr].prevBidder.bidAddr == msg.sender, "you can't cancel bid");
        // payable(msg.sender).transfer(auctions[sellerAddr].prevBidder.price);        
        auctions[sellerAddr].prevBidder.bidAddr = address(0);
    }

    function endAuction(address sellerAddr) external{
        require(sellers[sellerAddr].tokenId != 0, "incorrect address of seller"); // seller is exist
        require(sellers[sellerAddr].endAt <= block.timestamp, "auaction not finished!");        
        address highestBid = auctions[sellerAddr].currBidder.bidAddr;
        require(highestBid != sellerAddr, "the highest bid is the seller's bid");
        // if (auctions[sellerAddr].prevBidder.bidAddr != address(0)){
        //     payable(auctions[sellerAddr].prevBidder.bidAddr).transfer(auctions[sellerAddr].prevBidder.price);
        // }
        sellers[sellerAddr].NFTToken.transferFrom(sellerAddr,highestBid, sellers[sellerAddr].tokenId);
    }
}