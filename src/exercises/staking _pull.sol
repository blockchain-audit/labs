// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;
import "forge-std/console.sol";
import "./my_token.sol";

contract Staking_pool{
      struct User {
        uint256 sum_deposit; // true if the address is a collector, false otherwise
        uint256 date_deposit; // amount that the collector can withdraw
    }
    uint256 total;
    MyToken my_token;
    mapping(address=>User)public users;
    constructor() {

        my_token =new MyToken();
        my_token.mint(1000000);
    }
    receive() external payable depositCheck{}
    function whenDeposit(uint256 sum)public depositCheck {
        users[msg.sender].date_deposit=block.timestamp;
        users[msg.sender].sum_deposit=sum;
        total+=sum;

        console.log('address',msg.sender, 'time',block.timestamp + (7 days));
    }
      modifier depositCheck() {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        _; 
    }
    function withDraw(uint256 amount)public{
        require(users[msg.sender].date_deposit>=block.timestamp+(7 days),'You cannot withdraw , yet 7 days have not passed');
      
    uint256 totalSupply = my_token.totalSupply();
    // Perform floating-point division to calculate reward
    uint256 reward = ((total*0.1)*( users[msg.sender].sum_deposit/ total));
    MyToken token=my_token.mint(reward);
    // Ensure that the transfer amount does not exceed the gas stipend
    require(address(this).balance >= users[msg.sender].sum_deposit + reward, "Insufficient balance to withdraw");
    // Transfer the deposit and reward to the sender
    payable(msg.sender).transfer(users[msg.sender].sum_deposit + reward);
    total-=users[msg.sender].sum_deposit;

}
    

}