// SPDX-License-Identifier: MIT
pragma solidity >=0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "/home/user/myToken/new-project/script/myToken.sol";

contract Amm {
    MyToken a;
    MyToken b;
    uint256  k ;
    uint256 wad;
    uint256 prevX;
    uint256 prevY;
    mapping(address=>uint256)balanceUser;
    constructor() public{
        a = new MyToken();
        b = new MyToken();
        a.approve(address(this),1000);
        a.mint(address(this),1000);
        b.approve(address(this),1000);
        b.mint(address(this),2000);
        k = a.balanceOf(address(this)) * b.balanceOf(address(this));
        wad=10 ** 18;
    }
    function tradeAToB(uint256 amount,MyToken type_token)public{
        require(type_token.balanceOf(address(this)) >= amount,'DONT HAVE ENOUGH FROM THIS TOKENS');
        if(type_token == a){
            //token that he whant to trade
            //a i get
            //b i tranfer
           tradeAToB_orBToA (amount, a, b);
        }
        else{
            tradeAToB_orBToA (amount, b, a);
        }
    }
    function tradeAToB_orBToA (uint256 amount,MyToken x ,MyToken y) public{
            uint p = (k / (x.balanceOf(address(this)) + amount));
            //how many msg get after he trade
            uint c = y.balanceOf(address(this)) - p;
            //i tranfer to msg the token he whant
            y.transfer(msg.sender, c);
            //i get the token from msg to the Liquidity
            x.transferFrom(msg.sender ,(address(this)) ,amount);
    }
    function price()public{
        uint256 balanceA = a.balanceOf(address(this));
        uint256 balanceB = b.balanceOf(address(this));
    }
    function calculation(uint256 A, uint256 B, uint256 K) public view returns(uint256){
        uint256 divied = (K/A) * wad;
        uint256 z = ((divied/wad)-B)*wad;
        return z;
    }
    ///dont ight
    function addLiquidity(uint256 amountA,uint256 amountB)public{
        //היחס של כל מטבע בודד הוא בהתאם למה שרוצים a/b או b/a
        uint256 balanceA = a.balanceOf(address(this));
        uint256 balanceB = b.balanceOf(address(this));
        uint256 proportionalA = (balanceB/balanceA)*wad;
        uint256 proportionalB=(balanceA/balanceB)*wad;
        //בודקת עם היחס שווה גם ל2 הסכומים שקיבלתי A וB בהתאמה
        require((amountA / amountB) * wad == proportionalB ,'the proportional not same ');
        a.transfer(msg.sender, amountA);
        b.transfer(msg.sender, amountB);
        balanceUser[msg.sender] += amountB + amountA;
    }
    function removeLiquidity(uint256 amount)public{
        require(balanceUser[msg.sender] > 0,'you cant remove');
        uint256 total = b.balanceOf(address(this)) + a.balanceOf(address(this));
        //כמה יחסי  אני יכולה למשוך
        uint256 proportional = (balanceUser[msg.sender]/total) * wad;
        balanceUser[msg.sender]-=amount;
        a.transferFrom(address(this), msg.sender, proportional * a.balanceOf(address(this)));
        b.transferFrom(address(this), msg.sender, proportional * b.balanceOf(address(this)));
    }
}










