// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

import "@hack/homeStaking/myToken.sol";

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

    constructor (address _token)
    {
        token = MyToken(_token);
        owner = msg.sender;
        rewards = 1000000;
    }

    function staking(uint amount) external returns (bool)
    {
        Staker memory newStaker = Staker(block.timestamp, amount);
        stakers[msg.sender] = newStaker;
        totalStakersSupply += amount;
        return true;
    }

    function withdraw() external returns (bool);
    {
        
    }

}

