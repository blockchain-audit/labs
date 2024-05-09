// SPDX-License-Identifier: MIT
// https://solidity-by-example.org/defi/staking-rewards/
// Code is a stripped down version of Synthetix
pragma solidity ^0.8.24;

import "oz-contracts/token/ERC721/ERC721.sol";

contract Auction{

    struct Seller{
        ERC721 NFTToken;
        address addrSel;
        uint startDate;
        uint endDate;        
        bool started;
    }

    struct Bidder{
        uint price;
    }

    Seller seller;

    constructor() {
    }

    function initialize(uint preDate, uint duration/*, uint price*/) public{
        seller.addrSel = msg.sender;
        seller.started = true;
        seller.startDate = preDate;
        seller.endDate = preDate + duration;
    }
}