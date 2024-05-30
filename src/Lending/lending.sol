// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../../src/MyToken.sol";

contract Lending {
    MyToken public immutable _token;
    MyToken public immutable Dai;
    mapping(address => uint256) public borrowers;
    mapping(address => uint256) public collaterals;
    mapping(address => uint256) public depositTime;
    mapping(address => uint256) public deposits;
    address public owner;
    uint256 public ratePerWeek;
    uint256 immutable wad = 1e18;

    constructor(address tok, uint256 _rate) {
        _token = MyToken(tok);
        Dai = MyToken(0x6B175474E89094C44Da98b954EedeAC495271d0F);
        address owner = msg.sender;
        ratePerWeek = _rate;
    }

    function deposit(uint256 amount) public {
        require(depositTime[msg.sender] == 0, "You already have Dai here");
        Dai.transferFrom(msg.sender, address(this), amount);
        _token.mint(msg.sender, amount);
        depositTime[msg.sender] = block.timestamp;
        deposits[msg.sender] = amount;
    }

    function calculateReward(address user, uint256 amount) private returns (uint256) {
        uint256 rewardPerWeek = deposits[msg.sender] * ratePerWeek * amount;
        uint256 week = 60 * 60 * 24 * 7;
        uint256 duration = block.timestamp - depositTime[user];
        return rewardPerWeek * duration / week;
    }

    function ETHValue() public returns (uint256) {
        uint256 _ETH = 3087;
        return _ETH;
    }

    function unbond(uint256 amount) public {
        require(amount > 0, "invalid amount");
        uint256 reward = calculateReward(msg.sender, amount);
        _token.burn(msg.sender, amount);
        Dai.transferFrom(address(this), msg.sender, amount + reward);
    }

    function addCollateral(uint256 amount) public payable {
        payable(msg.sender).transfer(amount);
        collaterals[msg.sender] += amount;
    }

    function removeCollateral(uint256 amount) public {
        collaterals[msg.sender] -= amount;
    }

    function borrow(uint256 amount) public {
        uint256 limit = ETHValue() * collaterals[msg.sender] - borrowers[msg.sender];
        require(limit >= amount, "you don't have enough collaterals");
        borrowers[msg.sender] += amount;
        Dai.transferFrom(address(this), msg.sender, amount);
    }

    function calculateCommission() private returns (uint256) {}

    function repayBorrow(uint256 amount) external {
        require(amount > 0, "you can't repay this amount");
    }
}
