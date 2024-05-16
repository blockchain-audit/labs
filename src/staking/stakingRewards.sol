// SPDX-License-Identifier: MIT
// https://solidity-by-example.org/defi/staking-rewards/
// Code is a stripped down version of Synthetix
pragma solidity ^0.8.20;

import "../../src/like/IERC20.sol";

contract StakingRewards {
    IERC20 public immutable stakingToken;
    IERC20 public immutable rewardsToken;
    address public owner;
    uint256 public duration = 7 days; // [sec] reward duration
    uint256 public finish = 0; // [sec] finish reward time
    uint256 public updated; // [sec] last time rate updated
    uint256 public rate = 0; // [per] reward rate per sec
    uint256 public reward; // reward per token stored
    uint256 public staked; // total staked
    mapping(address => uint256) public paid; // user reward per token paid
    mapping(address => uint256) public rewards; // reward to be claimed
    mapping(address => uint256) public balances; // staked per user

    constructor(address st, address rt) {
        owner = msg.sender;
        stakingToken = IERC20(st);
        rewardsToken = IERC20(rt);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "not authorized");
        _;
    }
    // --- VIEWS

    function lastTime() public view returns (uint256) {
        return block.timestamp < finish ? block.timestamp : finish;
    }

    function accumulated() public view returns (uint256) {
        if (staked == 0) {
            return reward;
        }
        return reward + (rate * (lastTime() - updated) * 1e18) / staked;
    }

    function earned(address guy) public view returns (uint256) {
        return ((balances[guy] * (accumulated() - paid[guy])) / 1e18) + rewards[guy];
    }
    // --- STATE CHANGES

    modifier updateReward(address guy) {
        reward = accumulated();
        updated = lastTime();
        if (guy != address(0)) {
            rewards[guy] = earned(guy);
            paid[guy] = reward;
        }
        _;
    }

    function stake(uint256 amount) external updateReward(msg.sender) {
        require(amount > 0, "amount = 0");
        stakingToken.transferFrom(msg.sender, address(this), amount);
        balances[msg.sender] += amount;
        staked += amount;
    }

    function withdraw(uint256 amount) external updateReward(msg.sender) {
        require(amount > 0, "amount = 0");
        balances[msg.sender] -= amount;
        staked -= amount;
        stakingToken.transfer(msg.sender, amount);
    }

    function getReward() external updateReward(msg.sender) {
        uint256 r = rewards[msg.sender];
        if (r > 0) {
            rewards[msg.sender] = 0;
            rewardsToken.transfer(msg.sender, r);
        }
    }
    // --- ADMINISTRATION

    function setRewardsDuration(uint256 _duration) external onlyOwner {
        require(finish < block.timestamp, "reward duration not finished");
        duration = _duration;
    }

    function updateRate(uint256 amount) external onlyOwner updateReward(address(0)) {
        if (block.timestamp >= finish) {
            rate = amount / duration;
        } else {
            uint256 remaining = (finish - block.timestamp);
            uint256 leftover = remaining * rate;
            rate = (amount + leftover) / duration;
        }
        // Ensure the provided reward amount is not more than the balance
        // in the contract. This keeps the reward rate in the right
        // range, preventing overflows due to very high values of
        // rewardRate in the earned and rewardsPerToken functions;
        // Reward + leftover must be less than 2^256 / 10^18 to
        // avoid overflow.
        uint256 balance = rewardsToken.balanceOf(address(this));
        require(rate <= balance / duration, "provided reward too high");
        finish = block.timestamp + duration;
        updated = block.timestamp;
    }
}
