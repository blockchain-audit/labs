//SPDX-License-Identifier: MIT
// import "@openzeppelin/ERC721/ERC721.sol";
pragma solidity ^0.8.20;
import "../../../lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";

contract Auctions {
    struct Auction{
        address seller;
        bool started;
        bool ended;
        uint endAt;
        address highestBidder;
        uint highestBid;
        uint tokenID;
        address[] addresses;
    }
    mapping(uint=>mapping(address=>uint)) bids;
    mapping(uint=>Auction) public auctions;
    // ERC721 public NFT;

    event start(uint tokenID, uint endAt);
    event bid(uint tokenID, address bidder, uint amount);
    event withdraw(uint tokenID, address bidder);
    event end(uint tokenID, address winner);

    function startAuction(uint _tokenID, uint duration) external {
        require(auctions[_tokenID].seller == address(0), "can't duplicate auction");
        require(duration>0,"duration can't be 0");
        IERC721 token = IERC721(msg.sender);
        require(token.ownerOf(_tokenID)==msg.sender, "sender not owns the NFT");
        address[] memory a;
        auctions[_tokenID] = Auction({
            seller: msg.sender,
            started: true,
            ended: false,
            endAt: block.timestamp + duration,
            highestBid: 0,
            highestBidder: address(0),
            tokenID: _tokenID,
            addresses: a
        });
        // token.transferFrom(msg.sender, address(this), _tokenID);
        emit start(_tokenID, auctions[_tokenID].endAt);
    }
    function placeBid(uint tokenID) external payable{
        require(auctions[tokenID].seller != address(0), "auction does not exist");
        require(auctions[tokenID].started && block.timestamp<auctions[tokenID].endAt, "inactive auction");
        require(msg.sender.balance>=msg.value, "no money");
        require(msg.value+bids[tokenID][msg.sender]>auctions[tokenID].highestBid, "lower bid");
        payable(address(this)).transfer(msg.value);
        bids[tokenID][msg.sender] = bids[tokenID][msg.sender] + msg.value;
        auctions[tokenID].highestBid = bids[tokenID][msg.sender];
        auctions[tokenID].highestBidder = msg.sender;
        auctions[tokenID].addresses.push(msg.sender);
        emit bid(tokenID, msg.sender, bids[tokenID][msg.sender]);
    }
    function withdrawBid(uint tokenID) external {
        require(bids[tokenID][msg.sender]!=0, "sender didn't place bid");
        require(auctions[tokenID].highestBidder!=msg.sender, "highest bitter can't withdraw bid");
        payable(msg.sender).transfer(bids[tokenID][msg.sender]);
        delete bids[tokenID][msg.sender];
        emit withdraw(tokenID, msg.sender);
    }
    function endAuction(uint tokenID) external {
        require(auctions[tokenID].started && auctions[tokenID].endAt<=block.timestamp && !auctions[tokenID].ended, "auction does not end");
        auctions[tokenID].ended = true;
        IERC721 token = IERC721(address(this));
        bool isSeller = auctions[tokenID].highestBid==0;
        token.transferFrom(address(this), isSeller ? auctions[tokenID].seller : auctions[tokenID].highestBidder, tokenID);
        if(!isSeller)
            payable(auctions[tokenID].seller).transfer(auctions[tokenID].highestBid);
        delete bids[tokenID][auctions[tokenID].highestBidder];
        for(uint i=0;i<auctions[tokenID].addresses.length;i++){
            if(bids[tokenID][auctions[tokenID].addresses[i]]>0)
                payable(auctions[tokenID].addresses[i]).transfer(bids[tokenID][auctions[tokenID].addresses[i]]);
        }
        emit end(tokenID, auctions[tokenID].highestBidder);
    }

    // constructor(address _NFT, uint _tokenID, uint startingBid, uint duration) {
    //     seller = msg.sender;
    //     started=false;
    //     NFT = ERC721(_NFT);
    //     initiate(_tokenID, startingBid, duration);
    // }
    // function initiate(uint _tokenID, uint startingBid, uint duration) private {
    //     require(started==false, "auction started yet");
    //     // NFT = ERC721(_NFT);
    //     require(NFT.ownerOf(_tokenID)==seller, "seller not own the NFT");
    //     //transfer the NFT to the contract
    //     started=true;
    //     endAt = duration;
    //     NFT.transferFrom(seller, address(this), tokenID);
    //     bids[msg.sender] = startingBid;
    //     addresses.push(msg.sender);
    //     highestBid = startingBid;
    //     highestBidder = msg.sender;
    //     // payable(address(this)).transfer(msg.value);
    //     emit start(tokenID, endAt);
    // }
}