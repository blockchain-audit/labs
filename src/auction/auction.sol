// SPDX-License-Identifier: MIT
pragma solidity >=0.5.11;

import "openzeppelin-tokens/ERC721/ERC721.sol";
import "openzeppelin-tokens/ERC20/ERC20.sol";
import "forge-std/console.sol";

contract Auction {
    address ownerOfNFT;
    ERC721 NFTtoken;
    uint256 NFTtokenId;
    ERC20 token;
    uint256 public maxPrice;
    address public maxBidder;
    uint256 ended;

    constructor(address _NFTtoken, uint256 _NFTtokenId, address _token, uint256 _startPrice, uint256 duration) {
        // require(NFTtoken.ownerOf(NFTtokenId)== msg.sender,"the token not valid");

        NFTtoken = ERC721(_NFTtoken);
        token = ERC20(_token);
        maxPrice = _startPrice;
        NFTtokenId = _NFTtokenId;
        ended = block.timestamp + duration;
        ownerOfNFT = msg.sender;
    }

    function bid(uint256 amount) public {
        require(amount > maxPrice, "amount <= max");
        require(block.timestamp < ended, "time over");
        require(token.balanceOf(msg.sender) >= amount, "Not Enough Money");

        if (maxBidder != address(0)) {
            token.transfer(maxBidder, maxPrice);
        }
        if (amount == maxPrice && maxBidder == address(0)) {
            token.transfer(maxBidder, maxPrice);
        }
        token.transferFrom(msg.sender, address(this), amount);
        maxBidder = msg.sender;
        maxPrice = amount;
    }

    function winner() public {
        ended = block.timestamp;
        console.log("ended", ended);
        console.log("block.timestamp", block.timestamp);
        require(ended <= block.timestamp, "auction not over");
        require(maxBidder != address(0), "There were no bids");
        require(msg.sender == ownerOfNFT || msg.sender == maxBidder, "Not authorized");
        token.transfer(ownerOfNFT, maxPrice);

        // NFTtoken.transferFrom(address(this),maxBidder,NFTtokenId);
    }
}
