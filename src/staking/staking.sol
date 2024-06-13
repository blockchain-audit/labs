// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/console.sol";
import "../audit/approve.sol";
import "../tokens/myToken1.sol";

contract Staking {
    struct User {
        uint256 date;
        uint256 sum;
    }

    mapping(address => User[]) public database;
    uint256 public date;
    uint256 public stakingPool;
    uint256 public percent;
    address public owner;
    MyToken public myToken;

    constructor() {
        date = block.timestamp;
        stakingPool = 0;
        percent = 100;
        owner = payable(msg.sender);
        myToken = new MyToken();
        myToken.mint(10 ** 6);
    }

    modifier onlyOwner() {
        require(owner == msg.sender);
        _;
    }

    function pushDatabase(uint256 _date, uint256 _sum, address userAdress) public {
        database[userAdress].push(User({date: _date, sum: _sum}));
    }

    function deposit(uint256 amount) external payable {
        myToken.approve(msg.sender, amount);
        myToken.transferFrom(address(this), msg.sender, amount);
        database[msg.sender].push(User({date: block.timestamp, sum: amount}));
        stakingPool += amount;
    }

    // receive() external payable deposit{}

    function withdraw(uint256 amount) external {
        uint256 sum = 0;
        uint256 bonus;
        sum = calculateDays(amount);
        require(sum > 0, "You can't withdraw your money or You don't have enough money");
        bonus = calculateSum(sum);
        myToken.transferFrom(address(this), msg.sender, bonus);
        myToken.transfer(msg.sender, amount);
        stakingPool -= amount;
    }

    function calculateDays(uint256 amount) public returns (uint256) {
        uint256 sum = 0;
        for (uint256 i = 0; i < database[msg.sender].length && sum < amount; i++) {
            if (
                block.timestamp - 604800 >= database[msg.sender][i].date //time of 7 days in seconds
            ) {
                sum += database[msg.sender][i].sum;
                database[msg.sender][i].sum = 0;
                database[msg.sender][i].date = 0;
            }
        }
        if (sum < amount) return 0; // lock or you dont have enough money to withDraw
        return amount;
    }

    function calculateSum(uint256 sum) public view returns (uint256) {
        uint256 rate = sum / stakingPool;
        return rate * (percent * myToken.totalSupply());
    }

    function print(address userAddress) public view {
        for (uint256 i = 0; i < database[userAddress].length; i++) {
            console.log(database[userAddress][i].date, " date");
            console.log(database[userAddress][i].sum, " sum");
        }
    }
}
