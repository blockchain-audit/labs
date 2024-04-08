// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;
import "forge-std/console.sol";
import "./my_token.sol";

contract Staking_pool{
      struct User {
        uint256 sum_deposit; 
        uint256 date_deposit; 
    }
    uint256 total_staking;
    MyToken my_token;
    mapping(address=>User)public users;
    constructor(address token) {
        my_token = MyToken(token);
       // my_token.mint(10**6);
        total_staking=0;
    }
    //מאתחל את המבנה ומעדכן את הבריכת נזילות 
    function whenDeposit(uint256 sum)public {
        //הולכת לאשר את הכתובת הזאת שעכשיו נכנסת לבריכה שמפקידה 
        // my_token.approve(-,sum);

        //מבצע את ההפקדה בפועל לתוך הבריכה 
        // address(this)-זה הכתובת של החוזה חכם של הזה
        bool success = my_token.transferFrom(msg.sender, address(this),sum);
        require(success, "Deposit failed!"); 
        
        users[msg.sender].date_deposit=block.timestamp;
        users[msg.sender].sum_deposit=sum;

        total_staking+=sum;
        console.log('total_staking',total_staking);
        console.log('address this staking',address(this));
        console.log('address sender  ',msg.sender, 'time',block.timestamp + (7 days));

    }
    
    function withDraw(uint256 amount)public{
    require(users[msg.sender].date_deposit>=block.timestamp+(7 days),'You cannot withdraw , yet 7 days have not passed');
    uint256 reward = ((my_token.balanceOf(address(this)))*( users[msg.sender].sum_deposit/ total_staking));
    my_token.transfer(msg.sender,reward+amount);
    total_staking-=amount;
    users[msg.sender].sum_deposit-=amount;

}
    

}