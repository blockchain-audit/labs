// SPDX-License-Identifier: MIT
// https://solidity-by-example.org/defi/staking-rewards/
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../../../new-project/src/MyToken.sol";

contract StakingRewards {
    MyToken public immutable rewardsToken;
    address public user;
    uint public startAt;
    uint public updatedAt;
    uint public rewardRate;
    mapping(address => uint) public deposits;
    mapping(address => uint) public tokens;
    uint public totalSupply;
    mapping(address =>uint) public startDate;
    mapping(address =>uint) public rewards;
    uint public immutable WAD=10**18;

    constructor(address _rewardsToken) {
        user = msg.sender;
        rewardsToken=MyToken(_rewardsToken);

    }

    modifier onlyUser() {
        require(msg.sender == user, "not authorized");
        _;
    }

    function deposit(uint256 _amount) external onlyUser{
        require(_amount>0,"amount=0");
        _amount=_amount*WAD;
        rewardsToken.transferFrom(msg.sender,address(this),_amount);
        totalSupply += _amount;
        uint256 precentOfDeposit=_amount/totalSupply;
        deposits[msg.sender]+=precentOfDeposit;
        tokens[msg.sender]+=_amount;
        startDate[msg.sender]=block.timestamp;
        rewardsToken.mint(msg.sender,_amount);
    }

    modifier isSevenDays(){
        uint today=block.timestamp;
        require(today-startDate[msg.sender]>=7,"the reward duration is not finished yet");
        _;
    }

    function withdraw(uint _amount) external onlyUser isSevenDays{
        require(_amount>0,"amount = 0");
        require(tokens[msg.sender]>=_amount,"you don't have enouph tokens to withdraw");
        uint finalRewards = deposits[msg.sender]/rewards[msg.sender]*_amount;
        deposits[msg.sender]-=calc;
        rewardsToken.transferFrom(address(this),msg.sender,calc);
        totalSupply-=calc;
    }

}
