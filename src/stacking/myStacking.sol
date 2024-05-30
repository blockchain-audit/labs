/ SPDX-License-Identifier: MIT
// https://solidity-by-example.org/defi/staking-rewards/
pragma solidity ^0.8.20;
import "../../../MyToken/new-project/src/MyToken.sol";
 import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
contract StakingRewards{
      IERC20 public immutable stakingToken;
    MyToken public immutable rewardToken;
    address public owner;
    uint public startAt;
    uint public updatedAt;
    uint public rewardPerTokenStored;
    mapping(address => uint) public deposits;
    uint256 percentOfDeposit;//percent from totalSupply
    uint public totalSupply;
    mapping(address => uint) public startDate;
    mapping(address => uint256) public rewards;
    constructor(address _stakingToken, address _rewardToken) {
        owner = msg.sender;
        stakingToken = IERC20(_stakingToken);
        rewardToken=new MyToken();
        // totalSupply = 1000000;
    }
    modifier onlyOwner() {
        require(msg.sender == owner, "not authorized");
        _;
    }
    receive() external payable {}
    function getReward(uint256 _amount)  external  {
        rewardToken.transferFrom(address(this), msg.sender, _amount);
        rewards[msg.sender]+=_amount;
    }
    function Deposit(uint256 _amount)  external onlyOwner
     {
         require(_amount > 0, "amount = 0");
         stakingToken.transferFrom(msg.sender, address(this), _amount);
         totalSupply += _amount;
         percentOfDeposit=_amount*100/totalSupply;
         deposits[msg.sender] += percentOfDeposit;
         startDate[msg.sender]=block.timestamp;
         this.getReward(_amount);
    }
    modifier isSevenDay {//Checks if 7 days have passed since the deposit
      uint256 today =block.timestamp;
      require(today-(startDate[msg.sender]) >= 7, "reward duration not finished");
     _;
    }
   function withdraw(uint256 rewardToken) external isSevenDay
   {
    require(rewardToken > 0, "you dont have a rewardToken");
    require(deposits[msg.sender]>=rewardToken, "You don't have enough token you is drow");
    uint256 calc= (deposits[msg.sender]*totalSupply)/rewards[msg.sender]*rewardToken;
    deposits[msg.sender]-=calc;
    stakingToken.transferFrom(address(this), msg.sender,calc );//
    totalSupply -= calc;
}
}