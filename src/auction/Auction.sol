// SPDX-License-Identifier: MIT
pragma solidity >=0.5.11;

import "openzeppelin-tokens/ERC721/ERC721.sol";
import "forge-std/interfaces/IERC20.sol";
import "forge-std/console.sol";

contract Auction {
    address ownerOfNFT;
    ERC721 NFTtoken;
    uint256 NFTtokenId;
    IERC20 erc20Token;
    uint256 public maxPrice;
    address public maxBidder;
    uint256 ended;
    bool makeWinner = false;

    function start(address _NFTtoken, uint256 _NFTtokenId, address _erc20Token, uint256 _startPrice, uint256 duration)
        public
    {
        require(ended < block.timestamp, "already there is auction");
        if (makeWinner == false && ended != 0) {
            winner();
        }
        NFTtoken = ERC721(_NFTtoken);
        require(NFTtoken.ownerOf(_NFTtokenId) == msg.sender, "the token not valid");
        erc20Token = IERC20(_erc20Token);
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
        if (maxBidder != address(0)) {
            erc20Token.transfer(maxBidder, maxPrice);
        }
        erc20Token.transferFrom(msg.sender, address(this), amount);
        maxBidder = msg.sender;
        maxPrice = amount;
    }

    function winner() public {
        require(ended < block.timestamp, "auction not over");
        if(maxBidder == address(0)){
            NFTtoken.transferFrom(address(this), ownerOfNFT, NFTtokenId);
        }
        else{
            erc20Token.transfer(ownerOfNFT, maxPrice);
            NFTtoken.transferFrom(address(this), maxBidder, NFTtokenId);
        }
        makeWinner = true;
    }
}
