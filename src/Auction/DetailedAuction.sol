// SPDX-License-Identifier: MIT
// https://solidity-by-example.org/defi/staking-rewards/
// Code is a stripped down version of Synthetix

pragma solidity ^0.8.20;
import '../../lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol';

contract Auction {
    struct bidder{
        uint sum;
        bool flag = true;
        Seller seller;
    }
    struct Seller{
        address addressSeller;
        IERC721 NFTtoken;
        uint startTime;
        uint endTime;
        uint tokenId;
        uint startSum
    }
    
    mapping (address=>bidder) public bidders;
    address[] public stack;

    constructor(){
        bidders[address(this)].sum = seller.startSum;
        bidders[address(this)].flag = true;
        stack.push(address(this));
     }
//פונקציה להצעה של מוכר למכירה פומבית
    function createOfferToAuction(Seller seller) public {
        seller.NFTtoken.transfer(seller.addressSeller,address(this),seller.tokenId);   
    }
    modifier checkTime(Seller seller)public{
        require(block.timestamp > seller.endTime && block.timestamp < seller.startTime ,"The auction is closed");
        _;
    }
//פונקציה למשתמש להציע הצעה
    function addBid(uint _sum, Seller seller) public payable checkTime(seller){
        while(!bidders[stack[stack.length()-1]].flag){
            stack.pop();
        }
        require(_sum < bidders[stack[stack.length()-1]].sum , "you cant to bid this sum");
        bidders[msg.sender].sum = _sum;
        //address(this).transfer(_sum);
        stack.push(msg.sender);
    }
    function removeBid(Seller seller) public checkTime(seller){
        removeBidByOwner(seller,msg.sender)
    }
    function removeBidByOwner(Seller seller,address addr) public payable checkTime(seller){
        addr.transfer(bidders[addr].sum);
        bidders[addr].sum = 0;
        bidders[addr].flag = false;
    }
    //החזרת כספים אחרי סיום
    function returnMoney(Seller seller) public{
        while(stack.length() > 1)
        {
            if(bidders[stack[stack.length()-1]].flag ){
               removeBidByOwner(seller,stack[stack.length()-1])
            }
            stack.pop();
        }
    }
    //הבאה של NFT לזוכה
    //+ העברת הכסף של הזוכה למוכר
    function finishAuction(Seller seller) public {
        while(!bidders[stack[stack.length()-1]].flag){
            stack.pop();
        }
        require(stack.length()>1,"there is no bidders");
        seller.addressSeller.transfer(bidders[stack[stack.length()-1]].sum);
        seller.NFTtoken.transferFrom(seller.addressSeller,bidders[stack[stack.length()-1]],seller.tokenId);
        returnMoney(seller);

    }
//להוסיף RECIVE ולהתקן SELLER

}