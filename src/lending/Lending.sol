// SPDX-License-Identifier: MIT
pragma solidity >=0.5.11;

import "@labs/tokens/MyToken.sol";
import "forge-std/interfaces/IERC20.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract Lending {

    address owner;
    mapping(address => uint) deposites;
    MyToken bonds;
    IERC20 Dai;
    constructor(address bondsToken, address DaiToken)public{
        owner = msg.sender;
        bonds = new MyToken();
        Dai = IERC20(DaiToken);
        ETHvalue = _ETHvalue;
    }

    function deposit(uint countDai) public{
        deposites[msg.sender] = countDai;
        bonds.mint(msg.sender,countDai);
    }


    function reciveDai(uint countBonds)public{
        require(bonds.balanceOf(msg.sender)>=countBonds,"Not enough bonds");
        bonds.burn(msg.sender,countBonds);
        Dai.transfer(msg.sender,countBonds);
    }

    function borrow(uint amount)public{
        getLatestPrice();
    } AggregatorV3Interface




function getLatestPrice() public view returns (int) {
     priceFeed = AggregatorV3Interface(0xF79D6aFBb6dA890132F9D7c355e3015f15F3406F);
 (, int price, , , ) = priceFeed.latestRoundData();
 return price;
 }
}