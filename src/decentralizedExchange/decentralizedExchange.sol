// SPDX-License-Identifier:MIT
pragma solidity ^0.8.24;

import "forge-std/console.sol";
import "forge-std/interfaces/IERC20.sol";

contract DEX {

    IERC20 public tokenA;
    IERC20 public tokenB;

    uint256 public k;

    address owner;

    mapping (address => uint256) public investors;

    uint256 WAD = 10 ** 18;

    constructor(address a, address b) {
        tokenA = IERC20(a);
        tokenB = IERC20(b);
        
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "not authorized");
        _;
    }

    function initialize(uint256 initialBalanceA, uint256 initialBalanceB) public onlyOwner {
        tokenA.transferFrom(msg.sender, address(this), initialBalanceA);
        tokenB.transferFrom(msg.sender, address(this), initialBalanceB);

        k = initialBalanceA * initialBalanceB;
    }

    function getBalances() public view returns(uint256 balanceA, uint256 balanceB) {
        return (tokenA.balanceOf(address(this)), tokenB.balanceOf(address(this)));
    }

    function calculateBForATrade(uint256 amountA) public view returns(uint256 amountB) {
        uint256 balanceA = tokenA.balanceOf(address(this)) + amountA;
        uint256 balanceB = (k * WAD) / balanceA;
        amountB = tokenB.balanceOf(address(this)) - (balanceB / WAD);
        return amountB;
    }

    function calculateAForBTrade(uint256 amountB) public view returns(uint256 amountA) {
        uint256 balanceB = tokenB.balanceOf(address(this)) + amountB;
        uint256 balanceA = (k * WAD) / balanceB;
        amountA = tokenA.balanceOf(address(this)) - (balanceA / WAD);
        return amountA;
    }

    function tradeAToB(uint256 amountA) public {
        uint256 amountB = calculateBForATrade(amountA);

        tokenA.transferFrom(msg.sender, address(this), amountA);
        tokenB.approve(address(this), amountB);
        tokenB.transferFrom(address(this), msg.sender, amountB);
    }

    function tradeBToA(uint256 amountB) public {
        uint256 amountA = calculateAForBTrade(amountB);

        tokenB.transferFrom(msg.sender, address(this), amountB);
        tokenA.approve(address(this), amountA);
        tokenA.transferFrom(address(this), msg.sender, amountA);
    }

    function priceA(uint256 amountA) public view returns(uint256 amountB) {
        uint256 balanceA = tokenA.balanceOf(address(this));
        uint256 balanceB = tokenB.balanceOf(address(this));
        uint256 percent = (balanceA * WAD) / balanceB;
        amountB = (amountA * WAD) / percent;
        return amountB;
    }

    function priceB(uint256 amountB) public view returns(uint256 amountA) {
        uint256 balanceA = tokenA.balanceOf(address(this));
        uint256 balanceB = tokenB.balanceOf(address(this));
        uint256 percent = (balanceB * WAD) / balanceA;
        amountB = (amountB * WAD) / percent;
        return amountA;
    }

    function addLiquidity(uint256 amountA, uint256 amountB) public {
        require(amountA / amountB == tokenA.balanceOf(address(this)) / tokenB.balanceOf(address(this)), "Amount must be deposited in the correct ratio");
        
        uint256 sum = amountA + amountB;
        investors[msg.sender] += sum;

        tokenA.transferFrom(msg.sender, address(this), amountA);
        tokenB.transferFrom(msg.sender, address(this), amountB);

        k = tokenA.balanceOf(address(this)) * tokenB.balanceOf(address(this));
    }

    function getMaxLiquidityToRemove() public view returns(uint256 maxA, uint256 maxB) {
        uint256 balanceA = tokenA.balanceOf(address(this));
        uint256 balanceB = tokenB.balanceOf(address(this));
        uint256 total = balanceA + balanceB;
        uint256 ratio = (total * WAD) / investors[msg.sender];
        maxA = balanceA * WAD / ratio;
        maxB = balanceB * WAD / ratio;
        return (maxA, maxB);
    } 

    function removeLiquidity(uint256 amountA, uint256 amountB) public returns(uint256, uint256){
        require(investors[msg.sender] > 0, "You can not remove liquidity");

        (uint256 maxA, uint256 maxB) = getMaxLiquidityToRemove();
        require(amountA / amountB == tokenA.balanceOf(address(this)) / tokenB.balanceOf(address(this)), "Amount must be removed in the correct ratio");

        uint256 realAmountA = amountA > maxA? maxA: amountA;
        uint256 realAmountB = amountB > maxB? maxB: amountB;

        uint256 sum = realAmountA + realAmountB;
        investors[msg.sender] -= sum;

        tokenA.approve(address(this), realAmountA);
        tokenA.transferFrom(address(this), msg.sender, realAmountA);
        tokenB.approve(address(this), realAmountB);
        tokenB.transferFrom(address(this), msg.sender, realAmountB);

        k = tokenA.balanceOf(address(this)) * tokenB.balanceOf(address(this));

        return (realAmountA, realAmountB);
    }

}