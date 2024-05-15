// SPDX-License-Identifier: MIT
// https://solidity-by-example.org/defi/staking-rewards/
// Code is a stripped down version of Synthetix
pragma solidity ^0.8.20;

import "@hack/libs/ierc20.sol";

contract StakingRewards {
    IERC20 public immutable stakingToken;
    IERC20 public immutable rewardsToken;

    address public owner;
    uint256 public duration;        // [sec] time for payout
    uint256 public finish = 0;      // [sec] finish reward time
    uint256 public updated;         // [sec] last reward update
    uint256 public rate = 7 days;   // [per] reward rate per sec
    uint256 public acc;             // sum(reward rate * dt * 1e18 / total supply)
    uint256 public totalSupply;                  // total staked
    mapping(address => uint256) public paid;     // user reward per token paid
    mapping(address => uint256) public rewards;  // reward to be claimed
    mapping(address => uint256) public balanceOf;// staked per user

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
        acc = accumulated();
        updated = lastTime();
        if (_account != address(0)) {
            rewards[_account] = earned(_account);
            paid[_account] = acc;
        }
        _;
    }

    /// --- VIEWS

    function lastTime() public view returns (uint256) {
        return block.timestamp < finish ? block.timestamp : finish;
    }

    function accumulated() public view returns (uint256) {
        if (totalSupply == 0) {
            return acc;
        }
        return acc + (rate * (lastTime() - updated) * 1e18) / totalSupply;
    }

    function earned(address _account) public view returns (uint256) {
        return ((balanceOf[_account] * (accumulated() - paid[_account])) / 1e18) + rewards[_account];
    }

    // --- STATE CHANGES

    function stake(uint256 _amount) external updateReward(msg.sender) {
        require(_amount > 0, "amount = 0");
        stakingToken.transferFrom(msg.sender, address(this), _amount);
        balanceOf[msg.sender] += _amount;
        totalSupply += _amount;
    }

    function withdraw(uint256 _amount) external updateReward(msg.sender) {
        require(_amount > 0, "amount = 0");
        balanceOf[msg.sender] -= _amount;
        totalSupply -= _amount;
        stakingToken.transfer(msg.sender, _amount);
    }

    function getReward() external updateReward(msg.sender) {
        uint256 reward = rewards[msg.sender];
        if (reward > 0) {
            rewards[msg.sender] = 0;
            rewardsToken.transfer(msg.sender, reward);
        }
    }

    // --- ADMINISTRATION

    function setRewardsDuration(uint256 _duration) external onlyOwner {
        require(finish < block.timestamp, "reward duration not finished");
        duration = _duration;
    }

    function notifyRewardAmount(uint256 amount) external onlyOwner updateReward(address(0)) {
        if (block.timestamp >= finish) {
            rate = amount / duration;
        } else {
            uint remaining = (finish - block.timestamp);
            uint leftover = remaining * rate;
            rate = (amount + leftover) / duration;
        }

        // Ensure the provided reward amount is not more than the balance in the contract.
        // This keeps the reward rate in the right range, preventing overflows due to
        // very high values of rewardRate in the earned and rewardsPerToken functions;
        // Reward + leftover must be less than 2^256 / 10^18 to avoid overflow.
        uint balance = rewardsToken.balanceOf(address(this));
        require(rate <= balance / duration, "provided reward too high");

        finish  = block.timestamp + duration;
        updated = block.timestamp;
    }
}
