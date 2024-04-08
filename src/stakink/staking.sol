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
    uint public rewards;
    uint public totalStakersSupply;
    uint public wad = 1000000000000000000;

    constructor (address _token)
    {
        token = MyToken(_token);
        owner = msg.sender;
        token.mint(address(this), 1000000);
    }

    function staking(uint amount) external returns (bool)
    {
        token.approve(address(this), amount);
        token.transferFrom(msg.sender, address(this), amount);
        Staker memory newStaker = Staker(block.timestamp, amount);
        stakers[msg.sender] = newStaker;
        totalStakersSupply += amount;
        return true;
    }

    // function withdraw() external returns (bool);
    // {
        
    // }

    function calcReward(uint stakingtokens) external returns (uint)
    {
        uint percent = stakingtokens / totalStakersSupply * 100;
    } 
}

