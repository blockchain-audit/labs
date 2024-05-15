// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

import "./staking/myToken.sol";
import "./tokens/myERC721.sol";

contract Auction {
    MyERC721Token public tokenNFT;
    MyToken public myToken;

    bool public auctionStarted;
    uint public auctionStartDate;
    uint public auctionDuration;
    uint public auctionTokenId;

    address public currentHighestBidder;
    mapping(address => uint) public bidders;

    constructor (address _tokenNFT, address _myToken)
    {
        tokenNFT = MyERC721Token(_tokenNFT);
        myToken = _myToken;
    }


    function startAuction(uint tokenId, uint _auctionDuration) public {
        require(!auctionStarted, "auction already started");
        require(tokenNFT._ownerOf(tokenId) == msg.sender, "sender is not the owner of the token"); 

        auctionTokenId = tokenId;
        auctionDuration = _auctionDuration;
        auctionStarted = true;
        auctionStartDate = block.timestamp;

        tokenNFT.transferFrom(msg.sender, address(this), tokenId);
    }

    function bid(uint bidAmount) public returns(bool) {
        require(auctionStarted, "auction is not started");
        require(bidAmount > bidders[currentHighestBidder], "current highest bid amount is higher then your bid amount");

        currentHighestBidder = msg.sender;
        bidders[msg.sender] = bidAmount;
        myToken.transferFrom(msg.sender, address(this), bidAmount);

    }

    function withdrawBid() public {
        require(bidders[msg.sender], "you dont have a bid to withdraw");
        require(msg.sender != currentHighestBidder, "you can't withdraw your bid, you are the highest bidder");

        myToken.transfer(msg.sender, bidders[msg.sender]);
        delete bidders[msg.sender];
    }

    function endBid() public {
        
    }
}
