// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import "openzeppelin-tokens/ERC721/ERC721.sol";
import "openzeppelin-tokens/ERC20/ERC20.sol";
import "forge-std/console.sol";

contract Auction {
    address ownerOfNFT;
    ERC721 NFTtoken;
    uint NFTtokenId;
    ERC20 token;
    uint public maxPrice;
    address public maxBidder;
    uint ended;

    // פונקציה לאתחול החוזה
    function start(address _NFTtoken, uint _NFTtokenId, address _token, uint _startPrice, uint duration) public {
        require(ownerOfNFT == address(0), "Auction already started");
        ownerOfNFT = msg.sender;
        NFTtoken = ERC721(_NFTtoken);
        NFTtokenId = _NFTtokenId;
        token = ERC20(_token);
        maxPrice = _startPrice;
        ended = block.timestamp + duration;
    }

    function bid(uint amount) public {
        require(ownerOfNFT != address(0), "Auction not started yet");
        require(amount > maxPrice, "Amount should be greater than max price");
        require(block.timestamp < ended, "Auction has ended");
        require(token.balanceOf(msg.sender) >= amount, "Not Enough Tokens");

        if(maxBidder != address(0)){
            token.transfer(maxBidder, maxPrice);
        }
        if(amount == maxPrice && maxBidder == address(0)){
            token.transfer(maxBidder, maxPrice);
        }
        token.transferFrom(msg.sender, address(this), amount);
        maxBidder = msg.sender;
        maxPrice = amount;
    }

    function winner() public {
        require(ownerOfNFT != address(0), "Auction not started yet");
        ended = block.timestamp;
        console.log("ended", ended);
        console.log("block.timestamp", block.timestamp);
        require(ended <= block.timestamp, "Auction not over");
        require(maxBidder != address(0), "There were no bids");
        require(msg.sender == ownerOfNFT || msg.sender == maxBidder, "Not authorized");
        token.transfer(ownerOfNFT, maxPrice);

        // NFTtoken.transferFrom(address(this), maxBidder, NFTtokenId);
    }
}


// pragma solidity >=0.5.11;

// import "openzeppelin-tokens/ERC721/ERC721.sol";
// import "openzeppelin-tokens/ERC20/ERC20.sol";
// import "forge-std/console.sol";


// contract Auction {
//     address ownerOfNFT;
//     ERC721 NFTtoken;
//     uint NFTtokenId;
//     ERC20 token;
//     uint public maxPrice;
//     address public maxBidder;
//     uint ended;
//     constructor(address _NFTtoken,uint _NFTtokenId,address _token, uint _startPrice, uint duration){

//         //  require(NFTtoken.ownerOf(_NFTtokenId) == msg.sender,"the token not valid");

//         NFTtoken = ERC721(_NFTtoken);
//         token = ERC20(_token);
//         maxPrice = _startPrice;
//         NFTtokenId = _NFTtokenId;
//         ended = block.timestamp + duration;
//         ownerOfNFT = msg.sender;

//     } 

    

//     function bid(uint amount) public {
//         require(amount > maxPrice,"amount <= max");
//         require(block.timestamp < ended,"time over");
//         require(token.balanceOf(msg.sender) >= amount,"Not Enough Money");
       
//         if(maxBidder != address(0)){
//             token.transfer(maxBidder,maxPrice);
//         }
//         if(amount == maxPrice && maxBidder == address(0)){
//             token.transfer(maxBidder,maxPrice);
//         }
//         token.transferFrom(msg.sender,address(this),amount);
//         maxBidder = msg.sender;
//         maxPrice = amount;
//     }

//     function winner()public{
//         ended = block.timestamp;
//         console.log("ended",ended);
//         console.log("block.timestamp",block.timestamp);
//         require(ended <= block.timestamp,"auction not over");
//         require(maxBidder != address(0),"There were no bids");
//         require(msg.sender == ownerOfNFT || msg.sender == maxBidder,"Not authorized");
//         token.transfer(ownerOfNFT,maxPrice);

//         // NFTtoken.transferFrom(address(this),maxBidder,NFTtokenId);
//     }
// }