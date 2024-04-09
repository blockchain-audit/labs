// SPDX-License-Identifier: MIT

pragma solidity >=0.6.12 <0.9.0;
import "forge-std/console.sol";
// import "../audit/approve.sol";
import "../new_project/src/MyToken.sol";

contract Staking {

    struct User {        
        uint256 date;
        uint256 sum;
    } 

    mapping(address=> User[]) public database;
    uint256 date;
    uint256 public poolBalance ;
    uint256 poolsRich;
    uint256 percent;
    address owner;
    MyToken myToken;
    address rich;

    constructor(){
        date = block.timestamp;
        poolBalance = 0;
        // poolsRich = 1000000000;
        percent = 1000;
        owner = payable(msg.sender);
        rich = 0x7a3b914a1f0bD991BAf826F4fE9a47Bb9880d25f;
        myToken = new MyToken();
        myToken.mint(10**6);
    }

    modifier onlyOwner(){
        require(
            owner == msg.sender 
            );
            _;
    }
    //function
    function deposit(uint256 amount) external payable{
        for(uint256 i = 0; i < database[msg.sender].length; i++)
        {
            if(database[msg.sender][i].date == block.timestamp){
                database[msg.sender][i].sum += amount;
            }
            else{
                database[msg.sender].push(User({ date: block.timestamp, sum: amount }));
            }
        }
        myToken.transferFrom();
        poolBalance += amount;
    }

    // receive() external payable deposit{} 

    function withdraw(uint256 amount) external{
        uint256 sum = 0;
        uint256 bonus;
        sum = calculateDays(amount);
        require(sum != 0,"you can withdraw your money");
        bonus = calculateSum(sum);
        myToken.transferFrom(rich,msg.sender,bonus);
        myToken.transfer(msg.sender,amount);
        poolBalance -= amount; 
    }

    function calculateDays(uint256 amount)public returns ( uint256){
        uint256 sum = 0;
        for(uint256 i = 0; i<database[msg.sender].length; i++)
        {
            if(date - 604800 >= database[msg.sender][i].date) //time of 7 days in seconds
            {
                sum += database[msg.sender][i].sum;
            }
        }
        if(sum < amount)
            return 0;
        return amount;
    }

    function calculateSum(uint256 sum) public returns (uint256){
        uint256 rate = sum / poolBalance;
        return rate * (percent * poolsRich);
    }
}