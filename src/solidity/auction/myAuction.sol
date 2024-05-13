// SPDX-License-Identifier: MIT
// @Auther: Chana Cohen

    pragma solidity ^0.8.20;
    import "forge-std/console.sol";
    import "@openzeppelin/ERC721/ERC721.sol";
    import "@hack/solidity/auction/ERC721.sol";

    contract Auction{
        address public highestBidderAddress;
        uint public highestBid;
        bool isInitialized;
        
            address sellerAddress;
            MyERC721 NFT;
            uint tokenId;
            uint startingPrice;
            uint startTime;
            uint during;
            bool isStart;        

        event bid(address bider, uint amount);
        event End(address winner);

        mapping(address => uint) public biddes;
        address [] public biddesArr;
        
        constructor() {

        }

        //The NFT seller transfers the his token NFT to the contract
        function startAuction(uint _during, uint _startingPrice, uint _tokenId, address tokenNft) external onlySeller() {
            require(msg.sender == sellerAddress, "You need to be the owner of the nft.");
            NFT.transferFrom(msg.sender, address(this), tokenId);
            sellerAddress = msg.sender;
            NFT = MyERC721(tokenNft);
            tokenId = _tokenId;
            startingPrice = _startingPrice;
            startTime = block.timestamp;
            during = _during;
            isStart = true;    

        }

        modifier onlySeller() {
        require(
            msg.sender == sellerAddress,
            "Only seller can do it.");
            _;
        }

        modifier checkTime() {
        require(
            block.timestamp > startTime && block.timestamp < startTime + during,
            "You can only make offers higher than the current offer.");
            _;
        }

        //Add Bidd for the auction 
        function addBidd(uint sumBidd) internal checkTime(){
            require(sumBidd > highestBid || biddes[msg.sender] + sumBidd > highestBid, "Your bid must be greater than the current bid.");
            highestBidderAddress = msg.sender;
            highestBid = sumBidd;
            biddes[msg.sender] = sumBidd;
            biddesArr.push(msg.sender);
            payable(msg.sender).transfer(sumBidd);
        }

        //Remove bidd to the bidder if she not the highest bid
        function removeBidd() public payable checkTime(){
            require(msg.sender != highestBidderAddress, "The high bid cannot withdraw itself.");
            require(msg.sender != address(0), "You have no offer.");
            payable(msg.sender).transfer(biddes[msg.sender]);
            //delete biddes[msg.sender];
            NFT.transferFrom(address(this), msg.sender, address(msg.sender).balance);
        }

        //Return the monny to bideres
        function endAuction() public payable onlySeller(){
            require(msg.sender != highestBidderAddress, "The highest bidder can not withdraw his dib.");
            require(block.timestamp > startTime + during, "The money can only be withdrawn after the auction.");
            emit End(highestBidderAddress);
            NFT.transferFrom(address(this), highestBidderAddress, tokenId);
            payable(sellerAddress).transfer(highestBid);
            //delete biddes[highestBidderAddress];
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