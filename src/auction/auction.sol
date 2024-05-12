pragma solidity ^0.8.24;

import "forge-std/console.sol";
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
    address[] adr;
    }
    mapping ( uint256 => mapping( address => uint256 )) bids;
    mapping ( uint256 => auction) auctions;
    
    event Start (uint256 indexed tokenId, uint256 endAt);
    event Bid (uint256 indexed tokenId, address indexed bidder, uint256 amount);
    event Withdraw (uint256 indexed tokenId, address indexed bidder, uint256 amount);
    event End (uint256 indexed tokenId, address indexed winner, uint256 amount);
    receive() external payable {}

    function startAuction( uint256 id, uint256 duration) external {
        require (auctions[id].seller == address(0) , "auction already exist");
        require (duration > 0 , "there is no time for the auction");
        
        IERC721 token = IERC721(msg.sender);
         console.log("kkkkkk");
         console.log(msg.sender);

        console.log(token.ownerOf(id));

        // require(token.ownerOf(id) == msg.sender , "sender not owner");
       
        address[] memory adr;
        auctions[id] = auction({
            seller: msg.sender,
            tokenId: id,
            started: true,
            endAt: block.timestamp + duration,
            highestBid: 0,
            highestBidder: address(0),
            ended: false,
            adr : adr
        });

        // token.safeTransferFrom(msg.sender, address(this), id);


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
        auctions[id].adr.push(msg.sender);
 
        emit Bid(id, msg.sender, msg.value);
    }

    function withdraw(uint256 id) external {
        require (bids[id][msg.sender] > 0 , " you did not place a bid");
        require (auctions[id].highestBidder != msg.sender , "you are the highestBidder");
        uint256 amount = bids[id][msg.sender];
        payable(msg.sender).transfer(amount);
        delete bids[id][msg.sender];

        emit Withdraw(id, msg.sender, amount);
    }
    
    function endAuction(uint256 id) external {
        require (auctions[id].started == true, "this auction has not been started");
        require (auctions[id].endAt <= block.timestamp ,"the end time is not yet" );
        auctions[id].ended = false;
        
        IERC721 token = IERC721(address(this));
        if(auctions[id].highestBidder != address(0)){
        token.safeTransferFrom(address(this), auctions[id].highestBidder, id);
        payable(auctions[id].seller).transfer(auctions[id].highestBid);

        delete bids[id][auctions[id].highestBidder];

         for(uint i=0; i<auctions[id].adr.length; i++){
            if(bids[id][auctions[id].adr[i]] > 0)
                payable(auctions[id].adr[i]).transfer(bids[id][auctions[id].adr[i]]);
        }
            emit End(id, auctions[id].highestBidder, auctions[id].highestBid);
        }
        else{
            token.safeTransferFrom(address(this), auctions[id].seller, id);
            emit End(id, auctions[id].highestBidder, auctions[id].highestBid);

        }
    }


}