// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
// constant product

contract CP {
    IERC20 public immutable token0;
    IERC20 public immutable token1;
    uint256 public reserve0;
    uint256 public reserve1;
    uint256 public totalSupply;
    mapping(address => uint256) public balances;

    constructor(address t0, address t1) {
        token0 = IERC20(t0);
        token1 = IERC20(t1);
    }

    function mint(address to, uint256 amount) private {
        balances[to] += amount;
        totalSupply += amount;
    }

    function burn(address from, uint256 amount) private {
        balances[from] -= amount;
        totalSupply -= amount;
    }

    function swap(address addIn, uint256 amountIn) external returns (uint256 amountOut) {
        require(addIn == address(token0) || addIn == address(token1), "AMM3-invalid-token");
        require(amountIn > 0, "AMM3-zero-amount");
        bool isToken0 = addIn == address(token0);
        (IERC20 tokenIn, IERC20 tokenOut, uint256 reserveIn, uint256 reserveOut) =
            isToken0 ? (token0, token1, reserve0, reserve1) : (token1, token0, reserve1, reserve0);
        tokenIn.transferFrom(msg.sender, address(this), amountIn);
        uint256 amountInWithFee = (amountIn * 997) / 1000;
        amountOut = (reserveOut * amountInWithFee) / (reserveIn + amountInWithFee);
        tokenOut.transfer(msg.sender, amountOut);
        reserve0 = token0.balanceOf(address(this));
        reserve1 = token1.balanceOf(address(this));
    }

    function addLiquidity(uint256 amount0, uint256 amount1) external returns (uint256 shares) {
        token0.transferFrom(msg.sender, address(this), amount0);
        token1.transferFrom(msg.sender, address(this), amount1);
        // see `adding liquidity' doc
        if (reserve0 > 0 || reserve1 > 0) {
            require(reserve0 * amount1 == reserve1 * amount0, "x/y != dx/dy");
        }
        // see 'minting shares' doc
        if (totalSupply == 0) {
            shares = sqrt(amount0 * amount1);
        } else {
            shares = min((amount0 * totalSupply) / reserve0, (amount1 * totalSupply) / reserve1);
        }
        require(shares > 0, "shares = 0");
        mint(msg.sender, shares);
        reserve0 = token0.balanceOf(address(this));
        reserve1 = token1.balanceOf(address(this));
    }

    function removeLiquidity(uint256 _shares) external returns (uint256 amount0, uint256 amount1) {
        // bal0 >= reserve0
        // bal1 >= reserve1
        uint256 bal0 = token0.balanceOf(address(this));
        uint256 bal1 = token1.balanceOf(address(this));
        amount0 = (_shares * bal0) / totalSupply;
        amount1 = (_shares * bal1) / totalSupply;
        require(amount0 > 0 && amount1 > 0, "amount0 or amount1 = 0");
        // se 'burn' docs
        burn(msg.sender, _shares);
        reserve0 = bal0 - amount0;
        reserve1 = bal1 - amount1;
        token0.transfer(msg.sender, amount0);
        token1.transfer(msg.sender, amount1);
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
}
