// SPDX-License-Identifier: MIT

    pragma solidity ^0.8.20;
    import "forge-std/console.sol";
    import "@openzeppelin/ERC721/IERC721.sol";
    import "@hack/myTokens/ERC721.sol";

    contract Auction{
        address public highestBidderAddress;
        uint public highestBid;
        bool isInitialized;
        struct Seller{
            address sellerAddress;
            MyERC721 NFT;
            uint tokenId;
            uint startingPrice;
            uint startTime;
            uint during;
        }

        event bid(address bider, uint amount);
        event End(address winner);

        mapping(address => uint) public biddes;
        address [] public biddesArr;
        
        constructor(address tokenNft, Seller memory seller) {
           seller.NFT = MyERC721(tokenNft);
        }

        modifier onlySeller(Seller memory seller) {
        require(
            msg.sender == seller.sellerAddress,
            "Only seller can do it.");
            _;
        }

        modifier checkTime(Seller memory seller) {
        require(
            block.timestamp > seller.startTime && block.timestamp < seller.startTime + seller.during,
            "You can only make offers higher than the current offer.");
            _;
        }

        //The NFT seller transfers the his token NFT to the contract
        function moveNftToContract(Seller memory seller ) public {
           require(msg.sender == seller.sellerAddress, "You need to be the owner of the nft.");
            seller.NFT.transferFrom(msg.sender, address(this), seller.tokenId);
        }

        //Add Bidd for the auction 
        function addBidd(uint sumBidd, Seller memory seller) public checkTime(seller){
            require(sumBidd > highestBid || biddes[msg.sender] + sumBidd > highestBid, "Your bid must be greater than the current bid.");
            highestBidderAddress = msg.sender;
            highestBid = sumBidd;
            biddes[msg.sender] = sumBidd;
            biddesArr.push(msg.sender);
            payable(msg.sender).transfer(sumBidd);
        }

        //Remove bidd to the bidder if she not the highest bid
        function removeBidd(Seller memory seller) public payable checkTime(seller){
            require(msg.sender != highestBidderAddress, "The high bid cannot withdraw itself.");
            require(msg.sender != address(0), "You have no offer.");
            payable(msg.sender).transfer(biddes[msg.sender]);
            //delete biddes[msg.sender];
            seller.NFT.transferFrom(address(this), msg.sender, address(msg.sender).balance);
        }

        //Return the monny to bideres and Transfer the NFT to the winner
        function endAuction(Seller memory seller) public payable onlySeller(seller){
            require(msg.sender != highestBidderAddress, "The highest bidder can not withdraw his dib.");
            require(block.timestamp > seller.startTime + seller.during, "The money can only be withdrawn after the auction.");
            emit End(highestBidderAddress);
            seller.NFT.transferFrom(address(this), highestBidderAddress, seller.tokenId);
            payable(seller.sellerAddress).transfer(highestBid);
            //delete biddes[highestBidderAddress];
            //Remove the highest Bidder Address from array
            biddesArr.pop();
            for(uint i = 0; i < biddesArr.length; i++){
                if(biddes[biddesArr[i]] > 0){
                payable(biddesArr[i]).transfer(biddes[biddesArr[i]]);
                }
                //delete biddes[biddesArr[i]];
                biddesArr.pop();
            }
        }
    }