
pragma solidity ^0.8.24;

/// @titel simple stakink
/// @auther Yehudis Davis

contract stake {

address public owner;
uint256 public totalReward;
uint256 public totalStaking;
uint256 public beginDate;
mapping (address => uint256) public stakers;
mapping (address => uint ) public dates;

 function constructor(){
    owner = msg.sender;
    totalReward = 1,000,000;
    totalStaking = 0;
    
 }

receive() external payable{}

function stakeing() external payable {


    dates[msg.sender]= block.timestamp;
    stakers[msg.sender]=msg.value;
    totalStaking += msg.value;
}

}