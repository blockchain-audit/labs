// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

import "./myToken.sol";

struct Staker
{
    uint date;
    uint amount;
}

contract Staking 
{
    mapping(address => Staker) public stakers;
    address public owner;
    MyToken public token; 
    
    uint public totalStakersSupply;
    uint public wad = 1000000000000000000;
    uint public rewards = 1000000 * wad;

    constructor (address _token)
    {
        token = MyToken(_token);
        owner = msg.sender;
        token.mint(address(this), rewards);
    }

    function getStakerAmount(address add) external returns (uint)
    {
        return stakers[add].amount;
    }
        function getStakerDate(address add) external returns (uint)
    {
        return stakers[add].date;
    }

    function staking(uint amount) external returns (bool)
    {
        token.transferFrom(msg.sender, address(this), amount);
        stakers[msg.sender].amount = amount;
        stakers[msg.sender].date = block.timestamp;
        totalStakersSupply += amount;

        return true;
    }

    function withdraw() external returns (bool)
    {
        Staker memory staker = stakers[msg.sender];
        require(block.timestamp - staker.date > 7 days, "You must wait at least 7 days");
        uint reward = calcReward(staker.amount);
        token.transfer(msg.sender, reward + staker.amount);
        stakers[msg.sender].amount = 0; 

        return true;
    }

    function calcReward(uint stakingAmount) public returns (uint)
    {
        return stakingAmount * wad / (totalStakersSupply * rewards * 2 / 100 / wad);
    } 
}

