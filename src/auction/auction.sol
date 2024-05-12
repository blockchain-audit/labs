pragma solidity ^0.8.24;

import "../../lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";
contract Auction{

    struct auction{
    address seller;
    uint tokenId;
    bool started;
    bool ended;
    uint256 endAt;
    address highestBidder;
    uint256 highestBid;
    
    }
    mapping ( uint256 => mapping( address => uint256 )) bids;
    mapping ( uint256 => auction) auctions;
    
    event Start (uint256 indexed tokenId, uint256 endAt);
    event Bid (uint256 indexed tokenId, address indexed bidder, uint256 amount);
    event Withdraw ();
    event End ();
    receive() external payable {}

    function startAuction( uint256 id, uint256 duration) external {
        require (auctions[id].seller == address(0) , "auction already exist");
        require (duration > 0 , "there is no time for the auction");
        
        IERC721 token = IERC721(msg.sender);


        require(token.ownerOf(id) == msg.sender , "sender not owner");
        
        auctions[id] = auction({
            seller: msg.sender,
            tokenId: id,
            started: true,
            endAt: block.timestamp + duration,
            highestBid: 0,
            highestBidder: address(0),
            ended: false
        });

        token.safeTransferFrom(msg.sender, address(this), id);


        emit Start(id, block.timestamp + duration);
    }
    function bid(uint256 id) external payable{ 
        require (auctions[id].seller != address(0) , "auction does not exist");
        require (auctions[id].ended == false , "auction has already ended");
        require (msg.sender.balance >= msg.value , "you do not have this amount");
        require ( bids[id][msg.sender] + msg.value > auctions[id].highestBid);
        bids[id][msg.sender] += msg.value;
        auctions[id].highestBid =  bids[id][msg.sender];
        auctions[id].highestBidder = msg.sender;
 
        emit Bid(id, msg.sender, msg.value);
    }

    function withdraw(uint256 id) external {
        require (bids[id][msg.sender] > 0 , " you did not place a bid");
        require (auctions[id].highestBidder != msg.sender , "you are the highestBidder");
        payable (msg.sender).transfer(bids[id][msg.sender]);
        


        
        emit Withdraw();
    }
    
    function endAuction() external {
        emit End();
    }


}