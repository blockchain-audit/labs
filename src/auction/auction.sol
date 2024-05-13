pragma solidity ^0.8.24;

import "forge-std/console.sol";
import "../../lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";
import "../../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
contract Auction{

    struct auction{
    address seller;
    uint tokenId;
    bool started;
    bool ended;
    uint256 endAt;
    address highestBidder;
    uint256 highestBid;
    address[] addresses;

    }
    mapping ( uint256 => mapping( address => uint256 )) bids;
    mapping ( uint256 => auction) auctions;
     IERC721 public token;
    event Start (uint256 indexed tokenId, uint256 endAt);
    event Bid (uint256 indexed tokenId, address indexed bidder, uint256 amount);
    event Withdraw (uint256 indexed tokenId, address indexed bidder, uint256 amount);
    event End (uint256 indexed tokenId, address indexed winner, uint256 amount);

    constructor(address addressToken){
        token=IERC721(addressToken);
    }
    receive() external payable {}

    function startAuction( uint256 tokenid, uint256 duration ) external {
        require (auctions[tokenid].seller == address(0) , "auction already exist");
        require (duration > 0 , "there is no time for the auction");
        require(token.ownerOf(tokenid) == msg.sender , "sender not owner");

        address[] memory addresses;
        auctions[tokenid] = auction({
            seller: msg.sender,
            tokenId: tokenid,
            started: true,
            endAt: block.timestamp + duration,
            highestBid: 0,
            highestBidder: address(0),
            ended: false,
            addresses : addresses
        });

        token.transferFrom(msg.sender, address(this), tokenid);

        emit Start(tokenid, block.timestamp + duration);
    }

    function bid(uint256 tokenid) external payable{ 
        require (auctions[tokenid].seller != address(0) , "auction does not exist");
        require (auctions[tokenid].ended == false , "auction has already ended");
        require (msg.sender.balance >= msg.value , "you do not have this amount");
        require ( bids[tokenid][msg.sender] + msg.value > auctions[tokenid].highestBid);

        bids[tokenid][msg.sender] += msg.value;
        auctions[tokenid].highestBid =  bids[tokenid][msg.sender];
        auctions[tokenid].highestBidder = msg.sender;
        auctions[tokenid].addresses.push(msg.sender);
 
        emit Bid(tokenid, msg.sender, msg.value);
    }

    function withdraw(uint256 tokenid) external {
        require (bids[tokenid][msg.sender] > 0 , " you did not place a bid");
        require (auctions[tokenid].highestBidder != msg.sender , "you are the highestBidder");
        
        uint256 amount = bids[tokenid][msg.sender];
        payable(msg.sender).transfer(amount);
        delete bids[tokenid][msg.sender];

        emit Withdraw(tokenid, msg.sender, amount);
    }
    
    function endAuction(uint256 tokenid) external {
        require (auctions[tokenid].started == true, "this auction has not been started");
        require (auctions[tokenid].endAt <= block.timestamp ,"the end time is not yet" );
        auctions[tokenid].ended = false;
        
        IERC721 token = IERC721(address(this));
        if(auctions[tokenid].highestBidder != address(0)){
        token.safeTransferFrom(address(this), auctions[tokenid].highestBidder, tokenid);
        payable(auctions[tokenid].seller).transfer(auctions[tokenid].highestBid);

        delete bids[tokenid][auctions[tokenid].highestBidder];

         for(uint i=0; i<auctions[tokenid].addresses.length; i++){
            if(bids[tokenid][auctions[tokenid].addresses[i]] > 0)
                payable(auctions[tokenid].addresses[i]).transfer(bids[tokenid][auctions[tokenid].addresses[i]]);
        }
            emit End(tokenid, auctions[tokenid].highestBidder, auctions[tokenid].highestBid);
        }
        else{
            token.safeTransferFrom(address(this), auctions[tokenid].seller, tokenid);
            emit End(tokenid, auctions[tokenid].highestBidder, auctions[tokenid].highestBid);

        }
    }


}