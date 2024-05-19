// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

import "@hack/staking/myToken.sol";
import "@hack/tokens/ERC721.sol";

contract Auction {
    ERC721 public tokenNFT;
    MyToken public myToken;

    bool public auctionStarted;
    uint public auctionStartDate;
    uint public auctionDuration;
    uint public auctionTokenId;

    address public currentHighestBidder;
    mapping(address => uint) public bidders;

    constructor (address _tokenNFT, address _myToken)
    {
        tokenNFT = ERC721(_tokenNFT);
        myToken = MyToken(_myToken);
    }


    function startAuction(uint tokenId, uint _auctionDuration) public {
        require(!auctionStarted, "auction already started");
        require(tokenNFT.ownerOf(tokenId) == msg.sender, "sender is not the owner of the token"); 

        auctionTokenId = tokenId;
        auctionDuration = _auctionDuration;
        auctionStarted = true;
        auctionStartDate = block.timestamp;

        tokenNFT.transferFrom(msg.sender, address(this), tokenId);
    }

    function bid(uint bidAmount) public returns(bool) {
        require(auctionStarted, "auction is not started");
        require(bidAmount > bidders[currentHighestBidder], "current highest bid amount is higher then your bid amount");

        myToken.transfer(currentHighestBidder, bidders[currentHighestBidder]);

        currentHighestBidder = msg.sender;
        bidders[msg.sender] = bidAmount;
        myToken.transferFrom(msg.sender, address(this), bidAmount);

    }

    // function withdrawBid() public {
    //     require(bidders[msg.sender], "you dont have a bid to withdraw");
    //     require(msg.sender != currentHighestBidder, "you can't withdraw your bid, you are the highest bidder");

    //     myToken.transfer(msg.sender, bidders[msg.sender]);
    //     delete bidders[msg.sender];
    // }

    function endBid() public {
        require(auctionStarted, "auction is not started");
        require(block.timestamp > auctionStartDate + auctionDuration, "auction still did'nt finish the duration time");

        auctionStarted = false;
        tokenNFT.transferFrom(address(this), currentHighestBidder, tokenId);
    }
}
