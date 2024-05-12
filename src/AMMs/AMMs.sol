// SPDX-License-Identifier: MIT
// https://solidity-by-example.org/defi/staking-rewards/
// Code is a stripped down version of Synthetix
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract AMMs {
    IERC20 public immutable A;
    IERC20 public immutable B;
    uint256 private totalSuplly;
    uint256 private amountA;
    uint256 private balanceA;
    uint256 private amountB;
    uint256 private balanceB;
    uint256 private valueA;
    uint256 private valueB;

    constructor(uint256 Aa, uint256 Bb, address _A, address _B) {
        amountA = Aa; //Amount of tokens in the pool
        balanceA = Aa; //The value of each A token in the pool
        valueA = 1; //The value of the A tokens
        amountB = Bb; //Amount of tokens in the pool
        balanceB = Bb; //The value of each B token in the pool
        valueB = amountA / amountB; //The value of the B tokens
        totalSuplly = Aa * Bb;
        A = IERC20(_A);
        B = IERC20(_B);
    }
    //   function price(uint amount,uint first) public returns(uint){
    //     return first/amount;
    // }

    function price(uint256 amountA, uint256 amountB) public returns (uint256) {
        valueB = amountA / amountB;
        return valueB;
    }

    function swapA(uint256 amount) external {
        require(amount > 0, "you can't swap this amount");
        A.transferFrom(msg.sender, address(this), amount);
        amountA += amount;
        uint256 BB = amountB;
        amountB = totalSuplly / amountA;

        valueB = price(amountA, amountB);
        // balanceA=price(amountA,valueA);
        // balanceB=price(amountB,valueB);
        B.transferFrom(address(this), msg.sender, BB - amountB);
    }

    function swapB(uint256 amount) external {
        require(amount > 0, "you can't swap this amount");
        B.transferFrom(msg.sender, address(this), amount);
        amountB += amount;
        uint256 AA = amountA;
        amountA = totalSuplly / amountB;

        valueB = price(amountA, amountB);
        // balanceA=price(amountA,valueA);
        // balanceB=price(amountB,valueB);
        A.transferFrom(address(this), msg.sender, AA - amountA);
    }

    function provide(uint256 amount) external {
        uint256 putLiquidityA = amount / valueA + valueB;
        uint256 putLiquidityB = amount / (valueA + valueB) * valueB;
        A.transferFrom(msg.sender, address(this), putLiquidityA);
        B.transferFrom(msg.sender, address(this), putLiquidityB);
        amountA = amountA + putLiquidityA;
        amountB = amountB + putLiquidityB;
        totalSuplly = amountA * amountB;
    }
}
