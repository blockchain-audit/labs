// SPDX-License-Identifier: MIT
// https://solidity-by-example.org/defi/staking-rewards/
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../MyToken.sol";

contract StakingRewards {
    MyToken public immutable rewardsToken;
    address public user;
    uint256 public startAt;
    uint256 public updatedAt;
    uint256 public rewardRate;
    mapping(address => uint256) public deposits;
    mapping(address => uint256) public tokens;
    uint256 public totalSupply;
    mapping(address => uint256) public startDate;
    mapping(address => uint256) public rewards;
    uint256 public immutable WAD = 10 ** 18;

    constructor(address _rewardsToken) {
        user = msg.sender;
        rewardsToken = MyToken(_rewardsToken);
    }

    modifier onlyUser() {
        require(msg.sender == user, "not authorized");
        _;
    }

    function deposit(uint256 _amount) external onlyUser {
        require(_amount > 0, "amount=0");
        _amount = _amount * WAD;
        rewardsToken.transferFrom(msg.sender, address(this), _amount);
        totalSupply += _amount;
        uint256 precentOfDeposit = _amount / totalSupply;
        deposits[msg.sender] += precentOfDeposit;
        tokens[msg.sender] += _amount;
        startDate[msg.sender] = block.timestamp;
        rewardsToken.mint(msg.sender, _amount);
    }

    modifier isSevenDays() {
        uint256 today = block.timestamp;
        require(today - startDate[msg.sender] >= 7, "the reward duration is not finished yet");
        _;
    }

    // function withdraw(uint256 _amount) external onlyUser isSevenDays {
    //     require(_amount > 0, "amount = 0");
    //     require(tokens[msg.sender] >= _amount, "you don't have enouph tokens to withdraw");
    //     uint256 finalRewards = deposits[msg.sender] / rewards[msg.sender] * _amount;
    //     deposits[msg.sender] -= calc;
    //     rewardsToken.transferFrom(address(this), msg.sender, calc);
    //     totalSupply -= calc;
    // }
}
