// SPDX-License-Identifier: MIT
//spec --
//I calculate each person's reward like this:
//For example, Leah wants to withdraw 100 shekels from what she has, I calculate what percentage she has of totalSupply
//Let's say 10%.
//Now I calculate how much is 2% of the totalSupply. (The 2% is fixed),
//Then from the amount that comes out to me at 2%, Leah will get 10%
//I calculate each person's reward like this:
//For example, Leah wants to withdraw 100 shekels from what she has, I calculate what percentage she has of totalSupply
//Let's say 10%.
//Now I calculate how much is 2% of the totalSupply. (The 2% is fixed),
//Then from the amount that comes out to me at 2%, Leah will get 10%

pragma solidity >=0.8.20;

import "/home/user/myToken/new-project/script/myToken.sol";
import "forge-std/console.sol";

struct User {
    uint256 amount;
    uint256 time;
}

contract Staking {
    uint256 wad = 10 ** 18;
    MyToken public immutable myCoin;
    uint256 public totalSupply = 1000000;
    uint256 statePer = 2;
    mapping(address => User) public userStake;
    uint256 allReward;
    uint256 private lastCheckedTimestamp;

    constructor(address _myCoin) {
        myCoin = MyToken(_myCoin);
        totalSupply *= wad;
        myCoin.mint(address(this), totalSupply);
        lastCheckedTimestamp = block.timestamp;
    }

    function userStaking(address userAddress) public view returns (User memory) {
        return userStake[userAddress];
    }

    function deposit(uint256 sum) external {
        require(sum > 0, "You cannot deposit less than 0");
        myCoin.transferFrom(msg.sender, address(this),sum);
        userStake[msg.sender].amount += sum;
        userStake[msg.sender].time = block.timestamp;
        totalSupply += sum; //Total user deposits
    }

    function withdraw(uint256 sum) external {
        require(userStake[msg.sender].amount >= sum, "You don't have enough money in your account");
        require( block.timestamp - userStake[msg.sender].time  >= 7 days, "you cant withdraw beacuse you already into week");
        uint256 reward = this.getReward(sum);
         if (isNewYear()) {
            allReward = 0;
            lastCheckedTimestamp = block.timestamp;
        }
        allReward += reward;
        myCoin.transfer(msg.sender, reward + sum); //102
        totalSupply -= reward + sum;
        userStake[msg.sender].amount -= sum;
        
    }

    function isNewYear() internal view returns (bool) {
        return block.timestamp > lastCheckedTimestamp + 365 days; // נניח ששנה מחושבת כ-365 יום
    }

    function amount() external view returns (uint256) {
        return userStake[msg.sender].amount;
    }



    function changeTime() external returns (uint256) {
        uint256 a = 60 * 60 * 24 * 7;
        uint256 ti = userStake[msg.sender].time += a;
        console.log("plus week:  ", ti);
        return ti;
    }

    function getReward(uint256 sum) external view returns (uint256) {
        uint256 precent = sum * wad / totalSupply * 100; // 10%
        uint256 rewardPercent = totalSupply * statePer / 100; // 20
        uint256 reward = rewardPercent * (precent / 100) / wad; //2

        return reward;
    }

    function getBalance() external view returns (uint256) {
        return myCoin.balanceOf(address(this));
    }

}
