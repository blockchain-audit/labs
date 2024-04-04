
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
    totalReward = 1000000;
    totalStaking = 0;
    
 }

receive() external payable{}

/// @dev a function that receives the staked coins and saves the date .
function stakeing() external payable {
    require(msg.value > 0);
    dates[msg.sender] = block.timestamp;
    stakers[msg.sender] += msg.value;
    totalStaking += msg.value;
}

/// @dev a function that the staker couled pull his coins with geting his rewared
function getrReward() external payable{
    require(block.timestamp >= (dates[msg.value]+(7 days)),"you are not entitled to get a reward");
    uint reward = (((100/(totalStaking/stakers[msg.sender]))*(totalReward))/100);
    payable(msg.sender).send(reward);
}



}