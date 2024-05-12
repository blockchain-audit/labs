// SPDX-License-Identifier: MIT
pragma solidity >=0.5.11;

import "openzeppelin-tokens/ERC721/ERC721.sol";
import "forge-std/interfaces/IERC20.sol";
import "forge-std/console.sol";

contract Auction {
    address ownerOfNFT;
    ERC721 NFTtoken;
    uint256 NFTtokenId;
    IERC20 token;
    uint256 public maxPrice;
    address public maxBidder;
    uint256 ended;
    bool makeWinner = false;

    function start(address _NFTtoken, uint256 _NFTtokenId, address _token, uint256 _startPrice, uint256 duration)public{
        require(ended < block.timestamp,"already there is auction");
        if(makeWinner == false && ended != 0 ){
            winner();
        }
        NFTtoken = ERC721(_NFTtoken);
        require(NFTtoken.ownerOf(_NFTtokenId) == msg.sender, "the token not valid");
        token = IERC20(_token);
        maxPrice = _startPrice;
        NFTtokenId = _NFTtokenId;
        ended = block.timestamp + duration;
        ownerOfNFT = msg.sender;
        NFTtoken.transferFrom(msg.sender, address(this), _NFTtokenId);
        makeWinner = false;
    }

    function bid(uint256 amount) public {
        require(amount > maxPrice, "amount <= max");
        require(block.timestamp < ended, "time over");
        require(token.balanceOf(msg.sender) >= amount, "Not Enough Money");
        if (maxBidder != address(0)) {
            token.transfer(maxBidder, maxPrice);
        }
        token.transferFrom(msg.sender, address(this), amount);
        maxBidder = msg.sender;
        maxPrice = amount;
    }

    function winner() public {
        require(ended <= block.timestamp, "auction not over");
        require(maxBidder != address(0), "There were no bids");
        require(msg.sender == ownerOfNFT || msg.sender == maxBidder, "Not authorized");
        token.transfer(ownerOfNFT, maxPrice);
        NFTtoken.transferFrom(address(this), maxBidder, NFTtokenId);
        makeWinner = true;
    }
}
