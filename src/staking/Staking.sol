// SPDX-License-Identifier: MIT
pragma solidity >=0.5.11;

import "forge-std/console.sol";
import "@labs/tokens/MyToken.sol";

struct User {
    uint256 amount;
    uint256 time;
}

contract Staking {
    uint256 wad = 10 ** 18;
    MyToken myToken;
    uint256 public reward;
    uint256 public totalStaking = 0;
    mapping(address => User) public staker;

    constructor(address token) {
        myToken = MyToken(token);
        reward = 1000000 * wad;
        myToken.mint(1000000 * wad);
    }

    function stake(uint256 amount) public {
        staker[msg.sender].amount += amount;
        staker[msg.sender].time = block.timestamp;
        myToken.transferFrom(msg.sender, address(this), amount);
        totalStaking += amount;
    }

    function withdraw() public {
        require(block.timestamp - staker[msg.sender].time >= 7 days, "It hasn't been 7 days yet");
        uint256 amount = staker[msg.sender].amount;
        uint256 CountReward = calcReward(amount, totalStaking, reward);
        myToken.transfer(msg.sender, amount + CountReward);
        reward -= CountReward;
        totalStaking -= amount;
    }

    function calcReward(uint256 amount, uint256 staking, uint256 balanceReward) public pure returns (uint256) {
        uint256 CountReward = (balanceReward / 100 * 2 * 1e18 / ((staking * 1e18 / amount)));
        return CountReward;
    }
}
