// SPDX-License-Identifier: MIT
// https://solidity-by-example.org/defi/staking-rewards/
pragma solidity ^0.8.20;

import "@hack/like/IERC20.sol";

contract StakingRewards {
    IERC20 public immutable stakingToken;
    IERC20 public immutable rewardsToken;
    address public owner;
    // uint public duration;
    uint public startAt;
    uint public updatedAt;
    uint public rewardRate;
    // Sum of (reward rate * dt * 1e18 / total supply)
    uint public rewardPerTokenStored;
    // User address => rewardPerTokenStored per token paid
    mapping(address => uint) public deposits;
    // User address => rewards to be claimed
    // mapping(address => uint) public rewards;
    // Total staked
    uint public totalSupply;
    // User address => staked amount
    mapping(address => uint) public startDate;

    constructor(address _stakingToken, address _rewardToken) {
        owner = msg.sender;
        stakingToken = IERC20(_stakingToken);
        rewardsToken = IERC20(_rewardToken);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "not authorized");
        _;
    }

    modifier updateReward(address _account) {
        rewardPerTokenStored = rewardPerToken();
        updatedAt = lastTimeRewardApplicable();

        if (_account != address(0)) {
            rewards[_account] = earned(_account);
            userReward[_account] = rewardPerTokenStored;
        }

        _;
    }

    function deposit(uint256 _amount) external () {
        require(_amount>0,"amount=0");
        stakingToken.transferFrom(msg.sender,address(this),_amount);
        uint256 precentOfDeposit=_amount*100/(totalSupply+_amount);
        deposits[msg.sender]+=precentOfDeposit;
        totalSupply += _amount;
    }

    function withdraw() external (){
        
    }





    function lastTimeRewardApplicable() public view returns (uint) {
        return _min(finishAt, block.timestamp);
    }

    function rewardPerToken() public view returns (uint) {
        if (totalSupply == 0) {
            return rewardPerTokenStored;
        }

        return
            rewardPerTokenStored +
            (rewardRate * (lastTimeRewardApplicable() - updatedAt) * 1e18) /
            totalSupply;
    }

    function stake(uint _amount) external updateReward(msg.sender) {
        require(_amount > 0, "amount = 0");
        stakingToken.transferFrom(msg.sender, address(this), _amount);
        balanceOf[msg.sender] += _amount;
        totalSupply += _amount;
    }

    function withdraw(uint _amount) external updateReward(msg.sender) {
        require(_amount > 0, "amount = 0");
        balanceOf[msg.sender] -= _amount;
        totalSupply -= _amount;
        stakingToken.transfer(msg.sender, _amount);
    }

