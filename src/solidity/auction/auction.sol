// SPDX-License-Identifier: MIT

    pragma solidity ^0.8.20;
    import "forge-std/console.sol";
    import "@openzeppelin/ERC721/ERC721.sol";
    contract Auction{
        address public highestBidderAddress;
        uint public highestBid;
        bool isInitialized;
        struct Seller{
            address immutable sellerAddress;
            IERC721 NFT;
            uint startingPrice;
            bool started;
            bool ended;
            uint startDate;
            uint during;
        }

        event bid(address bider, uint amount);
        event End(address winner);

        mapping(address => uint) public biddes;
        address [] public biddesArr;
        
        constructor(address _NFT, uint _startBig, uint _durintion){
        initialize(_NFT, _startBig, _durintion);
        }
        
        function initialize(Seller seller) private{
            require(isInitialized == false, "The initialization is already done.");
            require(_NFT.tokenURI, "It is not sellers token");
            seller.started = true;
            seller.NFT = ERC721(_NFT);
            biddes[msg.sender] = startBig;
            biddesArr.push(msg.sender);
            seller.during = durinion;
            seller.startingPrice = _startingPrice;
            seller.startDate = block.timestamp;
            seller.highestBidderAddress = seller.sellerAddress;
            seller.highestBid = _startingPrice;
            isInitialized = true;
        } 

        modifier onlySeller(Seller seller) {
        require(
            msg.sender == seller.sellerAddress,
            "Only seller can do it.");
        _;
        }

        //I need to do it
        modifier checkTime(Seller seller) {
        require(
            msg.sender == seller.sellerAddress,
            "Only seller can do it.");
        _;
        }

        //The NFT seller transfers the his token NFT to the contract

        //Add Bidd for the auction 
        function addBidd(address _bidder, uint sumBidd) public{
            require(sumBidd > highestBid, "You can only make offers higher than the current offer.");
            //require(started == false && ended == false, "Bids can only be made during the auction");
            highestBid = sumBidd;
            highestBid = highestBid;
            biddes[_bidder] = sumBidd;
            biddesArr.push(_bidder);
        }

        //Remove bidd to the bidder if she not the highest bid

        //Return the monny to bideres
        function withdrawMonny(Seller seller) public payable{
            require(msg.sender != highestBidderAddress, "The highestBidder can not withdraw his dib.");
            require(msg.sender == seller.sellerAddress, "Only seller can return the monny to bidderes.");
            for(uint i = 0; i < biddesArr.length; i++){
                payable(biddesArr[i]).transfer(biddes[biddesArr[i]]);
                delete biddes[biddesArr[i]];
                biddesArr.pop();
            }
       
        //Transfer the NFT to the winner

        }
    }