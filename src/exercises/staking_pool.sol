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
    uint256 wad=10**18;
    mapping(address => User[]) public users;
    constructor(address token) {
        my_token = MyToken(token);
        
        my_token.mint((60)*wad);
        // reward = 1000000 * wad;
        total_staking=0;
    }
    function whenDeposit(uint256 sum)public {
        //מבצע את ההפקדה בפועל לתוך הבריכה 
        // address(this)-זה הכתובת של החוזה חכם של הזה
        require(sum>0,'Deposit amount must be greater than zero');
        bool success = my_token.transferFrom(msg.sender, address(this),sum);
        require(success, "Deposit failed!"); 
        User memory newUser=User({
            date_deposit:(block.timestamp/68400)+1,
            sum_deposit:sum
        });
        // users[msg.sender][date].date_deposit=date;
        // users[msg.sender][date].date_deposit=sum;
        users[msg.sender].push(newUser);

        // users[msg.sender].date_deposit=(block.timestamp/68400)+1;
        // users[msg.sender].sum_deposit=sum;

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
        uint256 s_mount=0;
        require(amount > 0,'Withdraw amount must be greater than zero');
        console.log('exsist', my_token.balanceOf(address(this)));

        require(amount  < my_token.balanceOf(address(this)),"cant withdraw more then exsist");
        for (uint i = 0; i < userArray.length && s_mount<amount; i++) {
            if(userArray[i].sum_deposit==0)break;
            if(userArray[i].date_deposit>=(((block.timestamp/68400)+1)+(7 days))){
                 current=(amount - s_mount <=userArray[i].sum_deposit) ? (amount - s_mount):userArray[i].sum_deposit;
                 calc=calcReward(current,userArray[i].sum_deposit,(my_token.balanceOf(address(this))),total_staking);
                    s_mount+=current;
                    my_token.transfer(msg.sender,calc+current);
                    total_staking-=current;
                    userArray[i].sum_deposit-=current;
                    console.log('calc',calc);
                    console.log('current',current);

                    my_token.burn(calc);
                }
                //if some from amountWithDraw not hava 7 day in staking he can take it without reward
             else{
                 for (uint i = i; i < userArray.length && s_mount<amount; i++) {
                    if(userArray[i].sum_deposit==0)break;
                    uint256 current=(amount - s_mount <=userArray[i].sum_deposit) ? (amount - s_mount):userArray[i].sum_deposit;
                    s_mount+=current;
                    my_token.transfer(msg.sender,current);
                    total_staking-=current;
                    userArray[i].sum_deposit-=current;
                }
            }

        }
     // require(userArray[i].date_deposit>=((block.timestamp/68400)+(7 days)),'You cannot withdraw , yet 7 days have not passed');
    // uint256 calc=calcReward(wad,users[msg.sender].sum_deposit,(my_token.balanceOf(address(this))),total_staking);
    // uint256 reward = ((my_token.balanceOf(address(this)))*( users[msg.sender].sum_deposit/ total_staking));
    // my_token.transfer(msg.sender,calc+amount);
    // total_staking-=amount;
    // users[msg.sender].sum_deposit-=amount;
     console.log('after withdraw',my_token.balanceOf(address(this)));

    }
    // function calcReward(uint256 amountWithDraw,uint256 user_sum_deposit,uint256 balance,uint256 total_staking)public pure returns(uint256){
    // uint256 calcFromAllAmount=(balance*((2*wad)/100))/(user_sum_deposit/ total_staking)*wad;
    // uint256 solutionReward= calcFromAllAmount*(amountWithDraw /user_sum_deposit);
    // return solutionReward;
    // }
    function calcReward(uint256 amountWithDraw,uint256 user_sum_deposit,uint256 balance,uint256 total_staking)public view returns(uint256){
    uint256 calcFromAllAmount = (balance * ((2 * wad) / 100)) / (user_sum_deposit / total_staking)*wad;
    uint256 solutionReward= calcFromAllAmount*(amountWithDraw /user_sum_deposit);
    return solutionReward;
}

}











