// SPDX-License-Identifier: MIT
// https://solidity-by-example.org/defi/staking-rewards/
// Code is a stripped down version of Synthetix

pragma solidity ^0.8.20;
import "../like/IERC20.sol";
import "forge-std/console.sol";
import "../audit/approve.sol";
import "../staking/MyToken.sol";
import "../staking/MyToken2.sol";
contract Amm1{
    
    struct tokens{
        uint tX;
        uint tY;
    }

    IERC20 x;
    IERC20 y;

    uint balanceX;
    uint balanceY;

    uint totalSupply;
    
    uint WAD;

    mapping(address => tokens) public users; 

    constructor(address _tokenX, address _tokenY){
        x = IERC20(_tokenX);
        y = IERC20(_tokenY);

        x.approve(address(this),100); 
        y.approve(address(this),100);

        _mint(100,100);
        WAD = 10**18;
    }
 
    function _mint(uint256 amountX, uint256 amountY) private {
        balanceX += amountX;
        balanceY += amountY;
        totalSupply = balanceX + balanceY;
    }

    function _burn(uint256 amountX, uint256 amountY) private {
        balanceX -= amountX;
        balanceY -= amountY;
        totalSupply = balanceX + balanceY;
    }
    function price() public view returns(uint){
        return balanceX > balanceY ? (balanceX * WAD / balanceY) : (balanceY * WAD /balanceX);
    }
 
    function tradeXToY(uint256 amount) public returns(uint){
        require(amount > 0, "amount is illegal");
        // x.approve(address(this),100);
        // x.approve(msg.sender,100);
        console.log(msg.sender, "msg.sender"); 
        console.log(x.balanceOf(msg.sender), "balanceOf.msg.sender");  
        x.transferFrom(msg.sender,address(this),amount);
        balanceX += amount;
        uint amountY = balanceY * WAD / price();
        console.log(amountY, "amountY");  
        uint result = balanceY - amountY;  
        console.log(result, "result");  
        require(result < balanceY, "There is no enough liquidity");
        console.log("dd",y.balanceOf(address(this)));
        y.transfer(msg.sender,result);
        balanceY -= result;
        return result;
    }

    function tradeYToX(uint amount) public returns(uint){
        require(amount > 0, "amount is illegal");
        y.transferFrom(address(msg.sender),address(this),amount);
        balanceY += amount;
        uint amountX =balanceX * WAD / price();
        uint result =balanceX - amountX;
        require(result <balanceX, "There is no enough liquidity");
        x.transfer(msg.sender,result);
        balanceX -= result;
        return result;
    }

    function addLiquidity(uint amountX, uint amountY) public { //->amount
        uint rate = amountX > amountY ? (amountX * WAD / amountY) : (amountY * WAD / amountX);
        require(rate == price(), "rate not equal");
        x.transferFrom(address(msg.sender),address(this),amountX);
        balanceX += amountX;
        y.transferFrom(address(msg.sender),address(this),amountY);
        balanceY += amountY;
        totalSupply = balanceX + balanceY;
        users[msg.sender].tX += amountX;
        users[msg.sender].tY += amountY;
    }

    function removeLiquidity(uint amountX, uint amountY) public { //->amount
        uint rate = amountX > amountY ? (amountX * WAD / amountY) : (amountY * WAD / amountX);
        require(rate == price(), "rate not equal");
        require(amountX <= balanceX, "There is no enough token X");
        require(amountY <= balanceY, "There is no enough token Y");
        require(amountX <= users[msg.sender].tX, "You don't have enough token Y");
        require(amountY <= users[msg.sender].tY, "You don't have enough token Y");
        x.transfer(address(msg.sender),amountX);
        balanceX -= amountX;
        y.transfer(address(msg.sender),amountY);
        balanceY -= amountY;
        totalSupply = balanceX + balanceY;
        users[msg.sender].tX -= amountX;
        users[msg.sender].tY -= amountY;
    }
}