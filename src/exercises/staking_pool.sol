// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;
import "forge-std/console.sol";
import "./my_token.sol";

contract Staking_pool{
    struct User {
        uint256 sum_deposit;
        uint256 date_deposit;
    }
    uint256 public total_staking;
    MyToken public my_token;
    uint256 public wad=10**18;
    mapping(address => User[]) public users;
    constructor(address token) {
        my_token = MyToken(token);
        my_token.mint((10**6)*wad);
        total_staking=0;
    }
    function whenDeposit(uint256 sum)public {
        //מבצע את ההפקדה בפועל לתוך הבריכה 
        // address(this)-זה הכתובת של החוזה חכם של הזה
        require(sum>0,'Deposit amount must be greater than zero');
        console.log('staking_poolllll',my_token.balanceOf(address(this)),'fhfh:',address(this));
        console.log('ggg',msg.sender);
        console.log('ggg',my_token.balanceOf(msg.sender));

        //אני מבצעת את הפונקציה הזאת ולכן צריך לעשות approve
        bool success = my_token.transferFrom(msg.sender, address(this),sum);
        require(success, "Deposit failed!"); 
        User memory newUser=User({
            date_deposit:((block.timestamp )/68400)+1,
            sum_deposit:sum
        });
        users[msg.sender].push(newUser);
        total_staking+=sum;
        console.log('total_staking',total_staking);
        console.log('address this staking',address(this));
        console.log('time :fffffff  ', 'time',((block.timestamp+(7 days)) /86400)+1);

    }
    
    function withDraw(uint256 amount)public{
         console.log('befor withdraw',my_token.balanceOf(address(this)));
        uint256 current;
        uint256 calc;
        User[] memory userArray = users[msg.sender];
        uint256 s_amount=0;
        require(amount > 0,'Withdraw amount must be greater than zero');
        console.log('exsist', my_token.balanceOf(address(this)));
        
       require(amount  < my_token.balanceOf(address(this)),"cant withdraw more then exsist");

       require(userArray[0].date_deposit+7<=((block.timestamp/68400)+1) &&( userArray[0].sum_deposit>0),'still not over 7 days');
       uint i ;
        for (i = 0;i < userArray.length && (s_amount < amount) && (userArray[i].date_deposit + 7 <= ((block.timestamp / 68400) + 1)) && (userArray[i].sum_deposit > 0);i++)
         {
                 current=(amount - s_amount <=userArray[i].sum_deposit) ? (amount - s_amount):userArray[i].sum_deposit;
                    s_amount+=current;
                    userArray[i].sum_deposit-=current;
        }
        if(s_amount == amount){
            calc=calcReward(amount,(my_token.balanceOf(address(this))));
            console.log(calc);
            my_token.transfer(msg.sender,calc+amount);
        }
        else{
            ///check i 
            userArray[i].sum_deposit=s_amount;
    }
    }
    function calcReward(uint256 amountWithDraw,uint256 balance)public returns(uint256){
    require(total_staking >0,'cant divied by zero');
    uint256 calcFromAllAmount = ((amountWithDraw/total_staking)*wad)*balance;
    uint256 solutionReward= calcFromAllAmount/wad+amountWithDraw;
    total_staking-=amountWithDraw;

    return solutionReward;
}
}
