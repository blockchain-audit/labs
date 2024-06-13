// SPDX-License-Identifier: MIT
// https://solidity-by-example.org/defi/staking-rewards/
// Code is a stripped down version of Synthetix

pragma solidity ^0.8.20;

import "../interfaces/IERC20.sol";
import "forge-std/console.sol";
import "../audit/approve.sol";
import "../tokens/myToken1.sol";
import "../tokens/myToken2.sol";

contract Amm1 {
    struct tokens {
        uint256 tX;
        uint256 tY;
    }

    IERC20 x;
    IERC20 y;

    uint256 balanceX;
    uint256 balanceY;

    uint256 totalSupply;

    uint256 WAD;

    mapping(address => tokens) public balances;

    constructor(address _tokenX, address _tokenY) {
        x = IERC20(_tokenX);
        y = IERC20(_tokenY);

        x.approve(address(this), 100);
        y.approve(address(this), 100);

        WAD = 10 ** 18;

        x.approve(msg.sender, 100);
        y.approve(msg.sender, 100);
        initialize(msg.sender, 100, 100);
    }

    function initialize(address from, uint256 amountX, uint256 amountY) private {
        x.transferFrom(address(from), address(this), amountX);
        balanceX += amountX;
        y.transferFrom(address(from), address(this), amountY);
        balanceY += amountY;
        totalSupply = balanceX + balanceY;
    }

    function mint(address to, uint256 amount) private {
        balances[to].tX += amount;
        balances[to].tY += amount;
        totalSupply += amount;
    }

    function burn(address from, uint256 amount) private {
        balances[from].tX -= amount;
        totalSupply -= amount;
    }

    function price() public view returns (uint256) {
        return balanceX > balanceY ? (balanceX * WAD / balanceY) : (balanceY * WAD / balanceX);
    }

    function tradeXToY(uint256 amount) public returns (uint256) {
        require(amount > 0, "amount is illegal");
        // x.approve(address(this),100);
        // x.approve(msg.sender,100);
        console.log(msg.sender, "msg.sender");
        console.log(x.balanceOf(msg.sender), "balanceOf.msg.sender");
        x.transferFrom(msg.sender, address(this), amount);
        balanceX += amount;
        uint256 amountY = balanceY * WAD / price();
        console.log(amountY, "amountY");
        uint256 result = balanceY - amountY;
        console.log(result, "result");
        require(result < balanceY, "There is no enough liquidity");
        console.log("dd", y.balanceOf(address(this)));
        y.transfer(msg.sender, result);
        balanceY -= result;
        return result;
    }

    function tradeYToX(uint256 amount) public returns (uint256) {
        require(amount > 0, "amount is illegal");
        y.transferFrom(address(msg.sender), address(this), amount);
        balanceY += amount;
        uint256 amountX = balanceX * WAD / price();
        uint256 result = balanceX - amountX;
        require(result < balanceX, "There is no enough liquidity");
        x.transfer(msg.sender, result);
        balanceX -= result;
        return result;
    }

    function addLiquidity(uint256 amountX, uint256 amountY) public {
        //->amount
        uint256 rate = amountX > amountY ? (amountX * WAD / amountY) : (amountY * WAD / amountX);
        require(rate == price(), "rate not equal");
        x.transferFrom(address(msg.sender), address(this), amountX);
        balanceX += amountX;
        y.transferFrom(address(msg.sender), address(this), amountY);
        balanceY += amountY;
        totalSupply = balanceX + balanceY;
        balances[msg.sender].tX += amountX;
        balances[msg.sender].tY += amountY;
    }

    function removeLiquidity(uint256 amountX, uint256 amountY) public {
        //->amount
        uint256 rate = amountX > amountY ? (amountX * WAD / amountY) : (amountY * WAD / amountX);
        require(rate == price(), "rate not equal");
        require(amountX <= balanceX, "There is no enough token X");
        require(amountY <= balanceY, "There is no enough token Y");
        require(amountX <= balances[msg.sender].tX, "You don't have enough token Y");
        require(amountY <= balances[msg.sender].tY, "You don't have enough token Y");
        x.transfer(address(msg.sender), amountX);
        balanceX -= amountX;
        y.transfer(address(msg.sender), amountY);
        balanceY -= amountY;
        totalSupply = balanceX + balanceY;
        balances[msg.sender].tX -= amountX;
        balances[msg.sender].tY -= amountY;
    }
}
