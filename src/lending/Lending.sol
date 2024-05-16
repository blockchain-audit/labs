// SPDX-License-Identifier: MIT
pragma solidity >=0.5.11;

import "@labs/tokens/MyToken.sol";
import "forge-std/interfaces/IERC20.sol";
import "../../../lib/chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract Lending {

    address owner;
    mapping(address => uint) deposites;
    MyToken bonds;
    IERC20 Dai;
    constructor(address bondsToken, address DaiToken)public{
        owner = msg.sender;
        bonds = new MyToken();
        Dai = IERC20(DaiToken);
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
    } 



function getLatestPrice() public view returns (int) {
  AggregatorV3Interface  priceFeed = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);


 (
            uint80 roundID,
            int256 price,
            uint256 startedAt,
            uint256 timeStamp,
            uint80 answeredInRound
        ) = priceFeed.latestRoundData();


//  (, int price, , , ) = priceFeed.latestRoundData();
 return price;
 }


}
