// SPDX-License-Identifier: MIT
pragma solidity >=0.5.11;

import "forge-std/console.sol";
import "forge-std/interfaces/IERC20.sol";
import "./MyToken.sol";

struct User {
    uint256 amount;
    uint256 time;
}

contract Stacking {
    MyToken myToken;
    address public owner;
    mapping(address => User) public staker;

    constructor(address token) {
        myToken = MyToken(token);
        owner = msg.sender;
        myToken.mint(1000000);
    }

    function stake(uint256 amount) public {
        staker[msg.sender].amount = amount;
        staker[msg.sender].time = block.timestamp;
        myToken.transfer(address(this), amount);
    }

    function withdraw() public {
        require(staker[msg.sender].time - block.timestamp >= 7 days,"It hasn't been 7 days yet");
            uint256 amount = staker[msg.sender].amount;
            uint256 reward = myToken.balanceOf(owner) / (myToken.balanceOf(address(this)) / amount);
            myToken.transferFrom(address(this), msg.sender, amount + reward);
    }
}
