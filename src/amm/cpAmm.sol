// SPDX-License-Identifier: MIT
// https://solidity-by-example.org/defi/staking-rewards/
// Code is a stripped down version of Synthetix

pragma solidity ^0.8.20;

import "../interfaces/IERC20.sol";
import "forge-std/console.sol";

contract CpAmm {
    IERC20 public immutable tokenA;
    IERC20 public immutable tokenB;

    uint256 public reserveA; // amount of tokenA
    uint256 public reserveB; // amount of tokenB

    uint256 public totalSupply; // amount of shares
    uint256 WAD = 10 ** 18;

    mapping(address => uint256) public balances; // shares per user

    constructor(address tA, address tB) {
        tokenA = IERC20(tA); // type of tokenA
        tokenB = IERC20(tB); // type of tokenB
    }

    function mint(address to, uint256 amount) private {
        balances[to] += amount;
        totalSupply += amount;
    }

    function burn(address from, uint256 amount) private {
        balances[from] -= amount;
        totalSupply -= amount;
    }

    function swap(address addToken, uint256 amountIn) external returns (uint256 amountOut) {
        require(addToken == address(tokenA) || addToken == address(tokenB), "AMM-invalid-token");
        require(amountIn > 0, "AMM-zero-amount");

        bool isTokenA = addToken == address(tokenA); // check if addToken is tokenA

        // initialize the variables by the type of user token;
        (IERC20 tokenIn, IERC20 tokenOut, uint256 reserveIn, uint256 reserveOut) =
            isTokenA ? (tokenA, tokenB, reserveA, reserveB) : (tokenB, tokenA, reserveB, reserveA);

        tokenIn.transferFrom(msg.sender, address(this), amountIn); // transfer the tokens (user want to swap) from user to poll

        // 0.3% fee for swaping
        uint256 amountInWithFee = (amountIn * 997) / 1000;
        amountOut = (amountInWithFee * reserveOut) / (reserveIn + amountInWithFee);

        tokenOut.transfer(msg.sender, amountOut); // transfer the tokens (after swap and fee) from poll to user

        reserveA = tokenA.balanceOf(address(this));
        reserveB = tokenB.balanceOf(address(this));
    }

    function addLiquidity(uint256 amountA, uint256 amountB) external returns (uint256 shares) {
        // when reserveA and reserveB equal 0 (in the first time - empty pool) we will not check the rate - no rate
        if (reserveA > 0 || reserveB > 0) {
            // reserve - before the change, amount - dx, dy
            require(reserveA * amountA == reserveB * amountB, "x/y !=dx/dy"); // check the rate of the pool
        }

        tokenA.transferFrom(msg.sender, address(this), amountA);
        tokenB.transferFrom(msg.sender, address(this), amountB);

        if (totalSupply == 0) {
            shares = sqrt(amountA * amountB); // share = sqrt(k)
        } else {
            shares = min((amountA * totalSupply) / reserveA, (amountB * totalSupply) / reserveB);
        }
        require(shares > 0, "shares = 0"); // when amountA or AmountB eq 0 the shares will be 0 because the multiply
        mint(msg.sender, shares); // update share for user

        reserveA = tokenA.balanceOf(address(this)); // update amount of tokenA
        reserveB = tokenB.balanceOf(address(this)); // update amount of tokenB
    }

    function removeLiquidity(uint256 _shares) external returns (uint256 amountA, uint256 amountB) {
        require(_shares <= balances[msg.sender], "you don't have this amount of shares");
        uint256 balA = tokenA.balanceOf(address(this));
        uint256 balB = tokenB.balanceOf(address(this));

        // save the ratio of the pool
        amountA = (_shares * balA) / totalSupply;
        amountB = (_shares * balB) / totalSupply;
        require(amountA > 0 && amountB > 0, "amountA or amountB = 0");

        burn(msg.sender, _shares); // update share for user

        // update amount of tokens
        reserveA = balA - amountA;
        reserveB = balB - amountB;

        // transfer amount of tokens to user
        tokenA.transfer(msg.sender, amountA);
        tokenB.transfer(msg.sender, amountB);
    }

    function sqrt(uint256 y) private pure returns (uint256 z) {
        if (y > 3) {
            z = y;
            uint256 x = y / 2 + 1;
            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }
        } else if (y != 0) {
            z = 1;
        }
    }

    function min(uint256 x, uint256 y) private pure returns (uint256) {
        return x <= y ? x : y;
    }

    //AMM

    // advantage:

    // disadvantage:
}
