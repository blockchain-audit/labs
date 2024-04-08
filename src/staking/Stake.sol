// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "solmate-erc20/contracts/SolmateERC20.sol";

contract CloudTokenStaking {
    uint256 public constant totalCloudTokens = 1000000; //Amount of components of tokens in the smart contract
    uint256 public beginDate; //Start date of the deposit period
    uint256 public endDate; //End date of the deposit period

    //Represents the token that users deposit into our smart contract.
    // This allows the contract to perform operations such as verifying the sending and receiving of tokens during deposit and settlement operations.
    SolmateERC20 public cloudToken;

    mapping(address => uint256) public stakedTokens;  //Saves the user and the deposited amount
    mapping(address => uint256) public stakingTimestamp; //Account address of the users for the date and time they deposited
    
    //Generated when a user makes a deposit of tokens to the smart contract.
    // The event contains the address of the account that made the deposit (depositor) and the amount of tokens deposited.
    event TokensStaked(address indexed staker, uint256 amount); 
    //Created when a user makes a compensation of a reward he received for his clerkship in the smart contract. 
    //The event contains the address of the account that made the compensation (the user who received the compensation)
    // and the amount of the reward he received.
    event RewardClaimed(address indexed staker, uint256 amount);

    //It checks if the current time is between the start date of the deposit period and its end date
    modifier onlyDuringStakingPeriod() {
        require(block.timestamp >= beginDate && block.timestamp <= endDate, "Staking period is over");
        _;
    }

    //This check checks if the current time is later than the end of the deposit period
    modifier onlyAfterStakingPeriod() {
        require(block.timestamp > endDate, "Staking period has not ended yet");
        _;
    }

    

    ////*******************////
    constructor(SolmateERC20 _cloudToken) {
        cloudToken = _cloudToken;
    }

    //
    function passed7DaysSinceStake(address _staker) public view returns (bool) {

         require(stakedTokens[_staker] > 0, "No tokens staked"); // Ensure the user has staked tokens
         uint256 depositTime = stakingTimestamp[_staker];
         uint256 sevenDaysInSeconds = 7 days; // Number of seconds in 7 days

         // Calculate the timestamp that represents 7 days after the deposit
         uint256 sevenDaysAfterDeposit = depositTime + sevenDaysInSeconds ;
  
         // Check if the current timestamp is greater than or equal to 7 days after the deposit timestamp
         return block.timestamp >= sevenDaysAfterDeposit;
    }


   //Allows the user to deposit tokens into the contract's smart account. It checks that the amount delivered to it is greater than zero,
   // and that the user has the appropriate number of tokens in his account. In addition, 
   //it verifies that the user has approved the transfer of the tokens from his account to the contract's smart account.
   // After the verifications, the function transfers the tokens from the user account to the smart contract account. 
   //In addition, it updates the deposited amount of the user in the smart portfolio of the contract, and marks the time when the deposit was made. 
   //Finally, the function broadcasts an event that informs the network about the operation performed,
   // and lists the address of the account that made the deposit and the amount of tokens visited.
    function stakeTokens(uint256 _amount) external onlyDuringStakingPeriod {
        require(_amount > 0, "Amount must be greater than 0");
        require(cloudToken.balanceOf(msg.sender) >= _amount, "Insufficient tokens to stake");  //Insufficient - לא מספיק
        require(cloudToken.allowance(msg.sender, address(this)) >= _amount, "You must approve tokens before staking"); //
        
        //Transfers the amount from the sender's address to the address of the smart contract
        cloudToken.transferFrom(msg.sender, address(this), _amount);

        stakedTokens[msg.sender] += _amount; //update amount
        stakingTimestamp[msg.sender] = block.timestamp; //Indicates the time when the deposit was made

        emit TokensStaked(msg.sender, _amount);
    }
    

    //Returns the estimated compensation that the specified user will receive after the end of the deposit period. 
    //It checks that the current time is greater than the end date of the deposit period,
    // and that the amount of tokens deposited by the specified user is positive. 
    //It then calculates the estimated compensation based on the amount of tokens 
    //the specified user has deposited relative to the total amount of tokens deposited by all users.
    // The compensation is calculated as a multiple of the amount of tokens deposited by the specified user,
    // divided by the total amount of tokens deposited by all users.
    function calculateReward(address _staker) public view returns (uint256) {
        require(passed7DaysSinceStake(_staker), "7 days have not passed since the deposit");
        require(block.timestamp > endDate, "Staking period has not ended yet");
        require(stakedTokens[_staker] > 0, "No tokens staked");
        
        uint256 totalStaked = getTotalStakedTokens(); //how many does he have
        uint256 totalReward = totalCloudTokens; //Total amount

        return (stakedTokens[_staker] * totalReward) / totalStaked; //estimated
    }

    function claimReward() external onlyAfterStakingPeriod {
        uint256 reward = calculateReward(msg.sender);
        require(reward > 0, "No reward to claim"); //You have compensation to withdraw

        //Performs the transfer of the compensation from the smart account of the contract to the specified account of the user
        cloudToken.transfer(msg.sender, reward); 
        
        //Activates an event that informs about the ongoing compensation.
        emit RewardClaimed(msg.sender, reward);
    }


    //Some tokens are deposited by all users
    function getTotalStakedTokens() public view returns (uint256) {
        uint256 totalStaked;
        uint256 i = 0;
        while (i < totalCloudTokens) {
             totalStaked += stakedTokens[address(i)];
             i++;
        }
        return totalStaked;
    }


}
