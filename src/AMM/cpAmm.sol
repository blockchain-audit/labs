// SPDX-License-Identifier: MIT
// https://solidity-by-example.org/defi/staking-rewards/
// Code is a stripped down version of Synthetix

pragma solidity ^0.8.20;
import "../../like/IERC20.sol";
import "forge-std/console.sol";
import "../../audit/approve.sol";

contract CpAmm{

    IERC20 public immutable tokenA;
    IERC20 public immutable tokenB;

    uint public reserveA;  // amount of tokenA
    uint public reserveB;  // amount of tokenB

    uint public totalSupply; // amount of tokens

    mapping (address => uint) public balances; // amount of tokens per user

    constructor(address tA, address tB) {
        tokenA = IERC20(tA);
        tokenB = IERC20(tB1);
    }

    function mint(address to, uint amount) private {
        balances[to] += amount;
        totalSupply   += amount;
    }

    function burn(address from, uint amount) private {
        balances[from] -= amount;
        totalSupply     -= amount;
    }

    function swap(address addToken, uint amountIn) external returns (uint amountOut) {
        require(addToken == address(tokenA) || addToken == address(tokenB),
                "AMM-invalid-token"
        );
        require(amountIn > 0, "AMM-zero-amount");

        bool isTokenA = addToken == address(tokenA); // check if addToken is tokenA
        
        // initialize the variables by the type of user token;   
        (IERC20 tokenIn, IERC20 tokenOut, uint reserveIn, uint reserveOut)
        = isTokenA
            ? (tokenA, tokenB, reserveA, reserveB)
            : (tokenB, tokenA, reserveB, reserveA);


        tokenIn.transferFrom(msg.sender, addresss(this), amountIn); // transfer the tokens (user want to swap) from user to poll

        // 0.3% fee for swaping
        uint amountInWithFee = (amountIn * 997) / 1000;
        amountOut = (reserveOut * amountInWithFee) /
                    (reserveIn + amountInWithFee);

        tokenOut.transfer(msg.sender, amountOut); // transfer the tokens (after swap and fee) from poll to user

        reserveA = tokenA.balanceOf(address(this));
        reserveB = tokenB.balanceOf(address(this));
    }

    function addLiquidity(uint amountA, uint amountB) external returns (uint shares) {
        tokenA.transferFrom(msg.sender, address(this), amountA); 
        tokenB.transferFrom(msg.sender, address(this), amountB);

        // when reserveA and reserveB equal 0 (in the first time - empty pool) we will not check the rate - no rate
        if (reserveA > 0 || reserve1 > 0){ // reserve - before the change, amount - dx, dy
            require(reserveA * amountA == reserveB * amountB, "x/y !=dx/dy"); // check the rate of the pool
        }

        if (totalSupply == 0){
            shares = sqrt(amountA * amountB); // the token for user
        } else {
            shares = min(
                (amountA * totalSupply) / reserveA,
                (amountB * totalSupply) / reserveB
            );
        }
        require(shares > 0 , "shares = 0");
        mint(msg.sender, shares);

        reserveA = tokanA.balanceOf(address(this)); // update amount of tokenA
        reserveB = tokanB.balanceOf(address(this)); // update amount of tokenB
    }

    function removeLiquidity( uint _shares) external returns (uint amountA, uint amountB){
        uint balA = tokenA.balanceOf(address(this));
        uint balB = tokenB.balanceOf(address(this));

        amountA = (_shares * balA) / totalSupply;
        amountB = (_shares * balB) / totalSupply;
        require(amountA > 0 && amountB > 0, "amountA or amountB = 0");

        burn(msg.sender, _shares);

        reserveA = balA - amountA;
        reserveB = balB - amountB;

        tokenA.transfer(msg.sender, amountA);
        tokenB.transfer(msg.sender, amountB);    
    }

    function sqrt(uint y) private pure returns (uint z) {
        if (y > 3) {
             z = y;
             uint x = y/2 +1;
             while(x < z) {
                z = x;
                x =(y / x + x) / 2;
             }
        } else if (y != 0) {
            z = 1;
        }
    }

    function min(uint x, uint y) private pure returns(uint) {
        return x <= y ? x : y;
    }

}
