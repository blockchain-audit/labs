// SPDX-License-Identifier: MIT
// @Auther: Chana Cohen

    pragma solidity ^0.8.20;
    import "forge-std/console.sol";
    import "@openzeppelin/ERC721/IERC721.sol";
    import "@hack/myTokens/ERC721.sol";

    contract Auction{
        address public highestBidderAddress;
        uint public highestBid;
        address public sellerAddress;
        MyERC721 public NFT;
        uint public tokenId;
        uint public startingPrice;
        uint public startTime;
        uint public during;
        bool public isStart;        

        event bid(address bider, uint amount);
        event End(address winner);

        //mapping(address => uint) public biddes;
        address [] public biddesArr;
        
        constructor() {

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

        //Initialize variables
        //The NFT seller transfers the his token NFT to the contract
        function startAuction(uint _during, uint _startingPrice, uint _tokenId, address tokenNft) external  onlySeller(){
            require(msg.sender == sellerAddress, "You need to be the owner of the nft.");
            //sellerAddress = msg.sender;
            NFT = MyERC721(tokenNft);
            tokenId = _tokenId;
            startingPrice = _startingPrice;
            startTime = block.timestamp;
            during = _during;
            isStart = true;    
            highestBidderAddress = address(0);
            highestBid = _startingPrice;
            NFT.transferFrom(msg.sender, address(this), _tokenId);
        }

        //Add Bidd for the auction 
        function addBidd(uint sumBidd) internal checkTime(){
            require(sumBidd > highestBid || address(msg.sender).balance + sumBidd > highestBid, "Your bid must be greater than the current bid.");
            highestBidderAddress = msg.sender;
            payable(msg.sender).transfer(sumBidd);
            highestBid = sumBidd + address(msg.sender).balance;
            //address(msg.sender).balance += sumBidd;
            biddesArr.push(msg.sender);
            emit bid(msg.sender, address(msg.sender).balance);
        }

        //Remove bidd to the bidder if she not the highest bid
        function removeBidd() public payable checkTime(){
            require(msg.sender != highestBidderAddress, "The high bid cannot withdraw itself.");
            require(msg.sender != address(0), "You have no offer.");
            payable(msg.sender).transfer(address(msg.sender).balance);
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
                if(address(biddesArr[i]).balance > 0){
                payable(biddesArr[i]).transfer(address(biddesArr[i]).balance);
                }
                //delete biddes[biddesArr[i]];
                biddesArr.pop();
            }
        }
    }