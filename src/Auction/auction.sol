// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../../new-project/lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";

contract Auction {
    IERC721 nft;
    mapping(address  => uint256) bidders;
    mapping(uint256 => address) indexes;
    uint256 counter;
    uint256 duration = 7 days;
    address public max;
    address payable public owner;

    constructor(address Nft,uint amount) {
        address owner = msg.sender;
        counter = 1;
        nft = IERC721(Nft);
        bidders[owner] = amount;
        max = owner;
    }

    function addBidder(uint amount) private {
        require(amount > 0, "amount is zero");
        require(amount > bidders[max], "The value is less than the initial value");
        max = msg.sender;
        nft.transferFrom(msg.sender, address(this), amount);
        bidders[msg.sender] = amount;
        counter += 1;
        indexes[counter] = msg.sender;
    }

    function AddBid(uint amount) external {
        if (block.timestamp >= duration) {
            endAuction();
        } else {
            addBidder(amount);
        }
    }

    modifier isOwner() {
        require(msg.sender == owner, " isnt owner");
        _;
    }

    function removOffer(address user) external isOwner {
        require(bidders[user] == bidders[max], "You cannot withdraw the money since you have the higher value");
        bidders[user] = 0;
    }

    function endAuction() private {
        while (counter > 0) {
            address bidder = indexes[counter];
            nft.transferFrom(address(this),bidder, bidders[bidder]);
            counter = counter - 1;
        }
    }
}