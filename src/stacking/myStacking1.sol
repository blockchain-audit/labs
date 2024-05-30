// SPDX-License-Identifier: MIT
// https://solidity-by-example.org/defi/staking-rewards/
pragma solidity ^0.8.20;
import "../../../MyToken/new-project/src/MyToken.sol";
 import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
contract StakingRewards{
    MyToken public immutable rewardToken;
    address public user;
    uint public WAD=10 ** 18;
    uint public startAt;
        uint public duration=7;
    uint public updatedAt;
    uint public rewardPerTokenStored;
    mapping(address => uint) public deposits;
    uint256 percentOfDeposit;//percent from totalSupply
    uint public totalSupply;
    mapping(address => uint) public startDate;
    mapping(address => uint256) public rewards;
    // BPS = 10 ** 4;
    constructor(address _rewardToken) {
        user = msg.sender;
        rewardToken = MyToken(_rewardToken);
    }
    modifier onlyUser() {
        require(msg.sender == user, "not authorized");
        _;
    }
    receive() external payable {}
    // function getReward(uint256 _amount)  external  {
    //     rewardToken.transferFrom(address(this), msg.sender, _amount);
    //     rewards[msg.sender]+=_amount;
    // }
    function Deposit(uint256 _amount)  external onlyUser
     {
         require(_amount > 0, "amount = 0");
         _amount=_amount*WAD;
         rewardToken.transferFrom(msg.sender, address(this), _amount);
         totalSupply += _amount;
         percentOfDeposit=_amount/totalSupply;
         deposits[msg.sender] += percentOfDeposit;
         startDate[msg.sender]=block.timestamp;
        //  this.getReward(_amount);
    }
    modifier isEnoughDays {//Checks if 7 days have passed since the deposit
      uint256 today =block.timestamp;
      require(today-(startDate[msg.sender]) >= duration, "reward duration not finished");
     _;
    }
   function withdraw(uint256 token) external isEnoughDays
   {
    require(token > 0, "you dont have a rewardToken");
    require(deposits[msg.sender]>=token, "You don't have enough token you is drow");
    uint256 calc= (deposits[msg.sender]*totalSupply)/rewards[msg.sender]*token;
    deposits[msg.sender]-=calc;
    rewardToken.transferFrom(address(this), msg.sender,calc );//
    totalSupply -= calc;
}
}