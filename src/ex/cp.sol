
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// constant product
contract CP {
    IERC20 public immutable token0;
    IERC20 public immutable token1;
    uint public reserve0;
    uint public reserve1;
    uint public totalSupply;
    mapping(address => uint) public balances;
    constructor(address t0, address t1) {
        token0 = IERC20(t0);
        token1 = IERC20(t1);
    }
    function mint(address to, uint amount) private {
        balances[to] += amount;
        totalSupply  += amount;
    }
    function burn(address from, uint amount) private {
        balances[from] -= amount;
        totalSupply    -= amount;
    }
    function swap(address addIn, uint amountIn) external
    returns (uint amountOut) {
        require(
            addIn == address(token0) || addIn == address(token1),
            "AMM3-invalid-token"
        );
        require(amountIn > 0, "AMM3-zero-amount");
        bool isToken0 = addIn == address(token0);
        (IERC20 tokenIn, IERC20 tokenOut, uint reserveIn, uint reserveOut)
         = isToken0
            ? (token0, token1, reserve0, reserve1)
            : (token1, token0, reserve1, reserve0);
        tokenIn.transferFrom(msg.sender, address(this), amountIn);
        uint amountInWithFee = (amountIn * 997) / 1000;
        amountOut = (reserveOut * amountInWithFee) /
                    (reserveIn + amountInWithFee);
        tokenOut.transfer(msg.sender, amountOut);
        reserve0 = token0.balanceOf(address(this));
        reserve1 = token1.balanceOf(address(this));
    }
    function addLiquidity(uint amount0, uint amount1) external
    returns (uint shares) {
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
            shares = min(
                (amount0 * totalSupply) / reserve0,
                (amount1 * totalSupply) / reserve1
            );
        }
        require(shares > 0, "shares = 0");
        mint(msg.sender, shares);
        reserve0 = token0.balanceOf(address(this));
        reserve1 = token1.balanceOf(address(this));
    }
    function removeLiquidity(
        uint _shares
    ) external returns (uint amount0, uint amount1) {
        // bal0 >= reserve0
        // bal1 >= reserve1
        uint bal0 = token0.balanceOf(address(this));
        uint bal1 = token1.balanceOf(address(this));
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
    function sqrt(uint y) private pure returns (uint z) {
        if (y > 3) {
            z = y;
            uint x = y / 2 + 1;
            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }
        } else if (y != 0) {
            z = 1;
        }
    }
    function min(uint x, uint y) private pure returns (uint) {
        return x <= y ? x : y;
    }
}
