// SPDX-License-Identifier:MIT
pragma solidity ^0.8.24;

import "forge-std/console.sol";

import "./cloudToken.sol";

contract Staking {

    struct Stake {
        uint256 amount;
        uint256 stakingDate;
    }

    mapping (address => Stake[]) public stakers;

    uint256 public totalStaked;
    uint256 public stakingDuration = 604800; // 7 * 24 * 60 * 60 - 7 days in seconds
    uint256 public beginDate;
    
    CloudToken public cloudToken;

    uint WAD = 10 ** 18;
    uint initialRewardBalance = 1000000 * WAD;
    
    constructor(address _cloudToken) {
        beginDate = block.timestamp;
        cloudToken = CloudToken(_cloudToken);
        cloudToken.mint(initialRewardBalance);
    }

    function getTotalStaked() public view returns (uint256) {
        return totalStaked;
    }

    function wasBeforeSevenDays(uint256 stakingDate) public view returns (bool){
        console.log("stakingDate", stakingDate);
        console.log("block.timestamp", block.timestamp);
        uint256 calculateDays = block.timestamp - stakingDuration;
        console.log("calculateDays", calculateDays);
        return calculateDays > stakingDate;
    }

    function getTotalStakedPerUser() public view returns(uint256 totalStakedPerUser) {
        for(uint256 i = 0; i < stakers[msg.sender].length; i++)
        {
            if(wasBeforeSevenDays(stakers[msg.sender][i].stakingDate))
                totalStakedPerUser += stakers[msg.sender][i].amount;
        }
    }

    function calculateReward() public view returns (uint256 calculatedReward) {
        uint256 totalStakedPerUser = getTotalStakedPerUser();
        calculatedReward = (totalStakedPerUser * cloudToken.totalSupply()) / totalStaked;
    }

    function stake(uint256 amountToDeposit) public {
        require(amountToDeposit > 0, "The amount must be greater than 0");
        console.log("msg.sender", msg.sender);
        console.log("address(this)", address(this));
        console.log("balance", cloudToken.balanceOf(msg.sender));
        cloudToken.transferFrom(msg.sender, address(this), amountToDeposit);
        Stake memory newStake = Stake({
            amount: amountToDeposit,
            stakingDate: block.timestamp
        });
        stakers[msg.sender].push(newStake);
        console.log("totalStaked", totalStaked);
        totalStaked += amountToDeposit;
        console.log("new", msg.sender, stakers[msg.sender][0].amount, stakers[msg.sender][0].stakingDate);
        console.log("totalStaked", totalStaked);
    }

    // function withdraw(uint256 amountToWithdraw) public {
    //     require(calculateReward() >= amountToWithdraw );
    //     require(rewardToken.totalSupply() >= amountToWithdraw);
    //     rewardToken.transferFrom(address(this), msg.sender, amountToWithdraw);
    //     stake((-1) * amountToWithdraw);
    // }
}