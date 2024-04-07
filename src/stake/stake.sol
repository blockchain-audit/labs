
pragma solidity ^0.8.24;

/// @titel simple stakink
/// @auther Yehudis Davis
import "../../lib/solmate/src/tokens/ERC20.sol";

contract stake is ERC20{
ERC20 public token;
address public owner;
uint256 public totalReward = 10000000;
uint256 public totalStaking;
uint256 public beginDate;
mapping (address => uint256) public stakers;
mapping (address => uint256) public dates;

constructor() ERC20("MyToken", "MTK" ,16) {
        _mint(address(this), totalReward * (10 ** uint256(16)));
        owner = msg.sender;
        totalStaking = 0;
    }

receive() external payable{}

/// @dev a function that receives the staked coins and saves the date .
function stakeing(uint256 value) external payable {
    require(value > 0);
    dates[msg.sender] = block.timestamp;
    stakers[msg.sender] += value;
    totalStaking += value;
    transferFrom(msg.sender,address(this),value);
}

/// @dev a function that the staker could pull all his coins with geting his rewared
function unlockAll() external payable{
    require(stakers[msg.sender]>0 , "you do not have locked coins");
    require(dates[msg.sender] + 7 days <= block.timestamp , "you are not entitled to get a rewared");
    uint256 rewared = stakers[msg.sender]/totalStaking*totalReward;
    transfer(msg.sender , rewared + stakers[msg.sender] );
    totalStaking -= stakers[msg.sender];
    delete stakers[msg.sender];
    delete dates[msg.sender];
}

/// @dev a function for the staker to unlock only some of his coins and gettig a rewared accordingly
function unlock(uint amount) external payable{
    require(stakers[msg.sender]>0 , "you do not have locked coins");
    require(dates[msg.sender] + 7 days <= block.timestamp , "you are not entitled to get a rewared");
    require (stakers[msg.sender] > amount ,"you do not have the currect amount");
    uint256 rewared = amount/totalStaking*totalReward;
    transfer(msg.sender , rewared + amount );
    totalStaking -= amount;
    stakers[msg.sender] -= amount;
}


// if the staker addes coins
// if the staker want to take out his coin before 7 days
// if the staker wants to take out only some of his coins


}