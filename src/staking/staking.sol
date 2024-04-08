// SPDX-License-Identifier: MIT
// https://solidity-by-example.org/defi/staking-rewards/
pragma solidity ^0.8.20;

import "labs/new-project/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "....//new-project/src/MyToken.sol";

contract StakingRewards {
    IERC20 public immutable stakingToken;
    MyToken public immutable rewardsToken;
    address public owner;
    uint public startAt;
    uint public updatedAt;
    uint public rewardRate;
    mapping(address => uint) public deposits;
    uint public totalSupply;
    mapping(address =>uint) public startDate;
    mapping(address =>uint) public rewards;

    constructor(address _stakingToken, address _rewardToken) {
        owner = msg.sender;
        stakingToken = IERC20(_stakingToken);
        rewardsToken=new MyToken();

    }

    modifier onlyOwner() {
        require(msg.sender == owner, "not authorized");
        _;
    }



    function deposit(uint256 _amount) external onlyOwner{
        require(_amount>0,"amount=0");
        stakingToken.transferFrom(msg.sender,address(this),_amount);
        totalSupply += _amount;
        uint256 precentOfDeposit=_amount*100/totalSupply;
        deposits[msg.sender]+=precentOfDeposit;
        startDate[msg.sender]=block.timestamp;
        getReward(_amount);
    }

    function getReward(uint256 _amount) external {
        rewardsToken.transferFrom(address(this),msg.sender,_amount);
        rewards[msg.sender]+=_amount;
    }
    modifier isSevenDays(){
        uint today=block.timestamp;
        require(today-startDate[msg.sender]>=7,"the reward duration is not finished yet");
    }

    function withdraw(uint _amount) external onlyOwner,isSevenDays{
        require(_amount>0,"amount = 0");
        require(deposits[msg.sender]>=_amount,"you don't have enouph tokens to withdraw");
        uint calc = deposits[msg.sender]/rewards[msg.sender]*_amount;
        deposits[msg.sender]-=calc;
        stakingToken.transferFrom(address(this),msg.sender,calc);
        totalSupply-=calc;
    }

}
