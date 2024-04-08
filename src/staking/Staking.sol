// SPDX-License-Identifier: MIT
pragma solidity >=0.5.11;

import "forge-std/console.sol";
import "./MyToken.sol";

struct User {
    uint256 amount;
    uint256 time;
}

contract Staking {
    uint256 wad = 10 ** 18;
    MyToken myToken;
    uint256 public reward;
    mapping(address => User) public staker;

    constructor(address token) {
        myToken = MyToken(token);
        reward = 1000000 * wad;
        myToken.mint(1000000 * wad);
    }

    function stake(uint256 amount) public {
        staker[msg.sender].amount = amount;
        staker[msg.sender].time = block.timestamp;
        myToken.transferFrom(msg.sender, address(this), amount);
    }

    function withdraw() public {
        require(staker[msg.sender].time - block.timestamp >= 7 days, "It hasn't been 7 days yet");
        uint256 amount = staker[msg.sender].amount;
        uint256 CountReward = calcReward(amount);
        myToken.transfer(msg.sender, amount + CountReward);
        reward -= CountReward;
    }


    function calcReward(uint256 amount) public view returns(uint256){
        uint256 CountReward =(reward / ((myToken.balanceOf(address(this)) / amount) * wad))*wad;
        return CountReward;
    }
}



