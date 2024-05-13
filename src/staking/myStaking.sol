// SPDX-License-Identifier: Unlicense

pragma solidity 0.8.20;

// @author: Chana Cohen
// @title Stake

//import {ERC20} from "../tokens/ERC20.sol";

import "forge-std/console.sol";
//import "./myERC20.sol";

contract Stake {
    //struct Staker{
    uint amountStaked;
    //uint lastStakerTime
    //}
    //owner: A public variable that is the address of the contract holder
    address public owner;
    //totalReward: A public variable thet is contain the amont of the amount of the prize that will be divided between all depositors
    uint public totalReward;
    mapping(address => uint) public stakers;
    mapping(address => uint) public dates;
    uint totalStaking;
    uint public constant stakingDuring = 7 days;
    //event Staked(address staker, uint amount);
    modifier isOwner() {
        require(msg.sender == owner, "Caller is not went worng");
        _;
    }

    constructor() {
        owner = msg.sender;
        totalReward = 1000000;
        totalStaking = 0;
        console.log(block.timestamp);
    }

    receive() external payable {}

    //Function of a body interested in depositing money in a contract
    function stake(uint amount) external payable {
        require(amount > 0, "Must stake more of zero");
        require(
            stakers[msg.sender] == 0,
            "Cannot stake again until previous stake is withdrawn"
        );
        stakers[msg.sender] = amount;
        //stakers[msg.sender] = msg.value;
        dates[msg.sender] = block.timestamp;
        //beginDate = block.timestamp;
        totalStaking = totalStaking + amount;

        // emit(stakers[msg.sender], amount);
    }

    function calculateRreward() public returns (uint) {
        require(
            block.timestamp >= dates[msg.sender] + 7 days,
            "You can receive the prize only after 7 days from the day of deposit."
        );
        uint reward = 0;
        //uint rewardPercent = 0;
        //Calculation of the percentage of the award and the amount of the award
        //reward = (totalReward * stakers[msg.sender]) / totalStaking;
        reward = totalReward * 3 / 100 * (stakers[msg.sender] / totalStaking);
        //rewardPercent = (stakers[msg.sender] / (totalStaking / 100));
        //uint reward = (totalReward * reward) / 100;

        uint totalAmount = reward + stakers[msg.sender];
        payable(msg.sender).transfer(totalAmount);
        stakers[msg.sender] = 0;
        dates[msg.sender] = 0 days;
        totalStaking -= stakers[msg.sender];
        totalReward -= reward;
        return reward;
    }
}