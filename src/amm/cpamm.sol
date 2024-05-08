pragma solidity ^0.8.24;

import "../../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract CPAMM {
    IERC20 public immutable token0;
    IERC20 public immutable token1;

    uint public reserve0;
    uint public reserve1;

    uint public totalSupply;
    mapping (address => uint) public balanceOf;

    constructor (address t0, address t1){
        token0 = IERC20(t0);
        token1 = IERC20(t1);
    }
    
    // mint tokens in to the contract and saves it in the balace of the msg sender
    //this happens when the msg sender adds liquidity
    function mint(address to, uint amount) private {
        balanceOf[to] += amount;
        totalSupply += amount;
    }

    // burns tokens from the pool and removes that amount from the balance of the msg sender
    // this happens when the msg sender removs liquidity
    function burn(address from, uint amount) private {
        balanceOf[from] -= amount;
        totalSupply -= amount;
    }


//the sender sends the token he wants to swap and the amount to swap
    function swap(address addIn, uint amountIn) external returns (uint amountOut) {
        // checks if the token is one of the two tokens that are in this pool
        require (addIn == address(token0) || addIn == address(token1),"AMM3-invalid-token");

        require (amountIn > 0 ,"AMM3-zero-amount");

        // 
        bool isToken0 = addIn == address(token0);
        (IERC20 tokenIn, IERC20 tokenOut, uint reserveIn, uint reserveOut) = isToken0
        ? (token0, token1, reserve0 ,reserve1)
        : (token1, token0, reserve1, reserve0);

        // tranfering the tokens to the contract
        tokenIn.transferFrom(msg.sender, address(this), amountIn);

        //taking of the fee 0.3%
        //and continuing with the amount - the fee

        uint amountInWithFee = (amountIn * 997) / 1000;

        //calculating the token to give to the sender accordding to the formula x*y=k
        amountOut = (reserveOut * amountInWithFee) / (reserveIn + amountInWithFee);
        
        //transfering to the sender the amount that was calculated
        tokenOut.transfer(msg.sender, amountOut);

        reserve0 = token0.balanceOf(address(this));
        reserve1 = token1.balanceOf(address(this));
    }
    
    //the sender sends two amounts to add
    function addLiquidity (uint amount0, uint amount1) external returns (uint shares) {
        token0.transferFrom(msg.sender, address(this), amount0);
        token1.transferFrom(msg.sender, address(this), amount1);

        //checks that the amounts are on the right retio
        if (reserve0 > 0 || reserve1 > 0) {
            require(reserve0 * amount1 == reserve1 * amount0, "x / y != dx / dy");
        }

        if (totalSupply == 0) {
            shares = sqrt(amount0 * amount1);
        }
        else {
            shares = min((amount0 * totalSupply) / reserve0 , (amount1 * totalSupply) / reserve1);
        }

        require(shares > 0, "shares = 0");
        mint(msg.sender, shares);
        reserve0 = token0.balanceOf(address(this));
        reserve1 = token1.balanceOf(address(this));

    }

    function removeLiquidity (uint shares) external returns (uint amount0, uint amount1){

        //get the balance of the tokens in the contract
        uint bal0 = token0.balanceOf(address(this));
        uint bal1 = token1.balanceOf(address(this));

        amount0 = (shares * bal0) / totalSupply;
        amount1 = (shares * bal1) / totalSupply;

        require(amount0 > 0 && amount1 > 0, "amount1 or amount0 = 0");

        burn(msg.sender, shares);
        reserve0 = bal0 - amount0;
        reserve1 = bal1 - amount1;

        token0.transfer(msg.sender, amount0);
        token1.transfer(msg.sender, amount1);
    }

    function sqrt(uint y) private pure returns (uint z ){
        if (y > 3){
            z = y;
            uint x = y / 2 + 1;
            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }
        }
        else if (y != 0){
            z = 1;
        }
    }
    function min (uint x, uint y) private pure returns (uint){
        return x <= y ? x : y;
    }

}
