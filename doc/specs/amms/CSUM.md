# Constant Sum AMM


* [constant-sum](https://medium.com/@solidity101/day-95-100-exploring-defi-with-the-constant-sum-amm-7402583c0d4e)


## Introduction to DeFi and AMMs
DeFi has taken the blockchain world by storm, revolutionizing the way we think about finance. It aims to recreate traditional financial systems with decentralized technologies. One of the key innovations within DeFi is Automated Market Makers (AMMs), which have played a pivotal role in the growth of decentralized exchanges (DEXs).

## What Are AMMs?
AMMs are smart contracts that facilitate the exchange of tokens on a blockchain. They provide liquidity and determine the price of assets within a given trading pair. Unlike traditional order book-based exchanges, AMMs use mathematical formulas to calculate prices and execute trades.

## Constant Sum AMMs
Constant Sum AMMs are a subset of AMMs that are designed to maintain a constant sum of assets in a trading pair. The most famous example of a Constant Sum AMM is the Uniswap V2 formula, which uses the formula:

```
x * y = k
```

Here, `x` and `y` represent the quantities of two tokens in a liquidity pool, and `k` is a constant. When a trade occurs, the product of `x` and `y` remains constant, ensuring that the sum of the tokens in the pool remains the same.

Let’s dive deeper into how Constant Sum AMMs work, why they are important, and how to implement one.

## The Inner Workings of Constant Sum AMMs
Constant Sum AMMs are built on the principle of supply and demand. When a user wants to trade tokens, the AMM adjusts the token prices based on the current token balances in the pool. Here’s a step-by-step breakdown of how it works:

1. Initialization
- A liquidity provider deposits an equal value of two tokens (e.g., ETH and DAI) into a smart contract that represents a Constant Sum AMM pool.

2. Price Calculation

- The smart contract calculates the initial price of Token A in terms of Token B using the formula `x * y = k`, where `x` and `y` are the token balances in the pool.

3. Trading

- When a user wants to trade, the smart contract calculates the price based on the current balances.
- If a user wants to buy Token A with Token B, the AMM increases the price of Token A and decreases the price of Token B.
- If a user wants to sell Token A for Token B, the AMM decreases the price of Token A and increases the price of Token B.
- The amount of tokens received depends on the price change, which is determined by the liquidity pool’s constant sum property.

4. Arbitrage Opportunities

- Traders can take advantage of price imbalances by executing arbitrage trades. If the price on the AMM differs significantly from the market price, arbitrageurs can make a profit by buying low and selling high (or vice versa).

5. Liquidity Provision
- Liquidity providers earn fees from trading activities. These fees are paid by traders and are proportional to the amount of liquidity provided.

## The Importance of Constant Sum AMMs
Constant Sum AMMs offer several advantages that have contributed to their popularity in DeFi:

1. Liquidity Provision

- Constant Sum AMMs incentivize liquidity providers to add funds to the pools, ensuring sufficient liquidity for traders.
- Liquidity providers earn fees on their deposited assets, making it an attractive way to earn passive income.

2. User-Friendly

- Constant Sum AMMs simplify trading by eliminating the need for order books and matching buyers with sellers automatically.
- Anyone can trade on these platforms without relying on centralized intermediaries.

3. Transparency

- The open-source nature of DeFi projects means that anyone can inspect the code and verify the protocol’s operations.
- Transactions on the blockchain are transparent and traceable.

4. Accessibility

- Constant Sum AMMs are accessible to anyone with an internet connection and a compatible wallet.
- They provide financial services to unbanked and underbanked populations worldwide.

## Implementing a Constant Sum AMM
Now, let’s get technical and explore how to implement a simple Constant Sum AMM using Solidity, Ethereum’s smart contract programming language. In this example, we’ll create a basic AMM for trading two tokens, Token A and Token B.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract ConstantSumAMM {
 string public name = "Constant Sum AMM";
 address public owner;
 uint256 public totalLiquidity;
 uint256 public tokenABalance;
 uint256 public tokenBBalance;
event Trade(address indexed trader, uint256 amountA, uint256 amountB);
constructor() {
 owner = msg.sender;
 }
// Function to initialize the liquidity pool
 function initialize(uint256 initialA, uint256 initialB) external {
 require(msg.sender == owner, "Only the owner can initialize the pool");
 require(totalLiquidity == 0, "Pool is already initialized");
 require(initialA > 0 && initialB > 0, "Initial balances must be greater than zero");
tokenABalance = initialA;
 tokenBBalance = initialB;
 totalLiquidity = initialA + initialB;
 }
// Function to calculate the price of Token A in terms of Token B
 function calculatePrice() public view returns (uint256) {
 return (tokenBBalance * 1e18) / tokenABalance; // Adjust decimals as needed
 }
// Function to trade Token A for Token B
 function tradeAToB(uint256 amountA) external {
 require(amountA > 0, "Amount must be greater than zero");
 require(tokenABalance >= amountA, "Insufficient Token A balance");
uint256 amountB = (amountA * tokenBBalance) / tokenABalance;
 tokenABalance -= amountA;
 tokenBBalance += amountB;
 emit Trade(msg.sender, amountA, amountB);
 }
// Function to trade Token B for Token A
 function tradeBToA(uint256 amountB) external {
 require(amountB > 0, "Amount must be greater than zero");
 require(tokenBBalance >= amountB, "Insufficient Token B balance");
uint256 amountA = (amountB * tokenABalance) / tokenBBalance;
 tokenBBalance -= amountB;
 tokenABalance += amountA;
 emit Trade(msg.sender, amountA, amountB);
 }
// Function to add liquidity to the pool
 function addLiquidity(uint256 amountA, uint256 amountB) external {
 require(amountA > 0 && amountB > 0, "Amounts must be greater than zero");
tokenABalance += amountA;
 tokenBBalance += amountB;
 totalLiquidity += amountA + amountB;
 }
// Function to remove liquidity from the pool
 function removeLiquidity(uint256 liquidity) external {
 require(liqu
idity > 0 && liquidity <= totalLiquidity, "Invalid liquidity amount");
uint256 shareA = (liquidity * tokenABalance) / totalLiquidity;
 uint256 shareB = (liquidity * tokenBBalance) / totalLiquidity;
tokenABalance -= shareA;
 tokenBBalance -= shareB;
 totalLiquidity -= liquidity;
// Transfer tokens to the liquidity provider
 // Be sure to handle token transfers safely
 // For simplicity, we omit that here
 }
}
```
Please note that this is a simplified example for educational purposes. In a real-world scenario, you would need to consider additional factors like fee collection, security, and optimizations.

##  Report : Constant Sum Automated Market Maker (CSAMM)
In this unique report, we will dissect and analyze the **CSAMM** (Constant Sum Automated Market Maker) smart contract, written in Solidity. This contract serves as a fundamental building block in the world of decentralized finance (DeFi), facilitating the exchange and liquidity provision of two tokens, token0 and token1.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CSAMM {
    IERC20 public immutable token0;
    IERC20 public immutable token1;

    uint public reserve0;
    uint public reserve1;

    uint public totalSupply;
    mapping(address => uint) public balanceOf;

    constructor(address _token0, address _token1) {
        // NOTE: This contract assumes that token0 and token1
        // both have same decimals
        token0 = IERC20(_token0);
        token1 = IERC20(_token1);
    }

    function _mint(address _to, uint _amount) private {
        balanceOf[_to] += _amount;
        totalSupply += _amount;
    }

    function _burn(address _from, uint _amount) private {
        balanceOf[_from] -= _amount;
        totalSupply -= _amount;
    }

    function _update(uint _res0, uint _res1) private {
        reserve0 = _res0;
        reserve1 = _res1;
    }

    function swap(address _tokenIn, uint _amountIn) external returns (uint amountOut) {
        require(
            _tokenIn == address(token0) || _tokenIn == address(token1),
            "invalid token"
        );

        bool isToken0 = _tokenIn == address(token0);

        (IERC20 tokenIn, IERC20 tokenOut, uint resIn, uint resOut) = isToken0
            ? (token0, token1, reserve0, reserve1)
            : (token1, token0, reserve1, reserve0);

        tokenIn.transferFrom(msg.sender, address(this), _amountIn);
        uint amountIn = tokenIn.balanceOf(address(this)) - resIn;

        // 0.3% fee
        amountOut = (amountIn * 997) / 1000;

        (uint res0, uint res1) = isToken0
            ? (resIn + amountIn, resOut - amountOut)
            : (resOut - amountOut, resIn + amountIn);

        _update(res0, res1);
        tokenOut.transfer(msg.sender, amountOut);
    }

    function addLiquidity(uint _amount0, uint _amount1) external returns (uint shares) {
        token0.transferFrom(msg.sender, address(this), _amount0);
        token1.transferFrom(msg.sender, address(this), _amount1);

        uint bal0 = token0.balanceOf(address(this));
        uint bal1 = token1.balanceOf(address(this));

        uint d0 = bal0 - reserve0;
        uint d1 = bal1 - reserve1;

        /*
        a = amount in
        L = total liquidity
        s = shares to mint
        T = total supply

        s should be proportional to increase from L to L + a
        (L + a) / L = (T + s) / T

        s = a * T / L
        */
        if (totalSupply > 0) {
            shares = ((d0 + d1) * totalSupply) / (reserve0 + reserve1);
        } else {
            shares = d0 + d1;
        }

        require(shares > 0, "shares = 0");
        _mint(msg.sender, shares);

        _update(bal0, bal1);
    }

    function removeLiquidity(uint _shares) external returns (uint d0, uint d1) {
        /*
        a = amount out
        L = total liquidity
        s = shares
        T = total supply

        a / L = s / T

        a = L * s / T
          = (reserve0 + reserve1) * s / T
        */
        d0 = (reserve0 * _shares) / totalSupply;
        d1 = (reserve1 * _shares) / totalSupply;

        _burn(msg.sender, _shares);
        _update(reserve0 - d0, reserve1 - d1);

        if (d0 > 0) {
            token0.transfer(msg.sender, d0);
        }
        if (d1 > 0) {
            token1.transfer(msg.sender, d1);
        }
    }
}

interface IERC20 {
    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint amount);
    event Approval(address indexed owner, address indexed spender, uint amount);
}
```
## Contract Overview
The CSAMM contract comprises various functions and data structures designed to create and manage a liquidity pool for two tokens. Here are the key components:

## Token Reserves and Balances
- reserve0 and reserve1: These variables store the current reserve balances of token0 and token1, respectively.

- totalSupply: This variable keeps track of the total supply of liquidity tokens minted.

- balanceOf: A mapping that associates Ethereum addresses with their respective liquidity token balances.

## Swap Function
The `swap` function allows users to swap one of the two tokens for the other within the CSAMM pool. Notable features include:

- Input validation to ensure that the provided token is either token0 or token1.

- Calculation of the output token amount, which includes a 0.3% fee on the input amount.

- Dynamic selection of input and output tokens based on user input.

- Transfer of input tokens from the user to the CSAMM contract.

- Transfer of output tokens from the CSAMM contract to the user.

## Liquidity Provision and Removal
The `addLiquidity` and `removeLiquidity` functions allow users to provide liquidity to the CSAMM pool and subsequently withdraw it. Key features include:

- Transfer of token0 and token1 tokens to the CSAMM contract when adding liquidity.

- Calculation of shares to mint based on provided token amounts, considering the current reserves and total supply.

- Minting and burning of liquidity tokens to/from the user’s address.

- Transfer of liquidity tokens during the removal of liquidity.

## Security Considerations
While the CSAMM contract provides essential functionality for a decentralized exchange, it’s crucial to acknowledge potential security considerations:

- Token Approval: Users must approve the CSAMM contract to spend their tokens before interacting with it. Ensure proper token allowance management.

- Fee Structure: The contract applies a 0.3% fee on swaps, which might need adjustments depending on your use case.

- Testing and Auditing: Rigorous testing and auditing are essential to identify and mitigate security vulnerabilities.

## Innovative DeFi Building Block
The CSAMM contract showcases how automated market makers (AMMs) work in the DeFi space. Its simplicity makes it an excellent starting point for those looking to dive into DeFi development. However, it’s important to remember that real-world applications may require additional features, such as fee distribution mechanisms and advanced security measures.

This report only scratches the surface of DeFi development. As you explore further, consider exploring impermanent loss mitigation strategies, governance mechanisms, and enhanced user interfaces to create a robust and user-friendly DeFi platform.

## Contract Addressability and Interoperability
The CSAMM contract interacts with two token contracts, token0 and token1. To use this contract effectively, it’s essential to understand the token standards (e.g., ERC-20) and the functions provided by these tokens.

In Conclusion; The CSAMM contract represents a vital building block in the decentralized finance ecosystem. It provides the foundation for decentralized exchanges, enabling users to swap tokens and provide liquidity while earning fees. As DeFi continues to evolve, the principles illustrated in this contract will play a significant role in shaping the financial landscape of the future.

Remember that successful DeFi development requires a deep understanding of blockchain, smart contract security, and the economic implications of DeFi protocols. Continuous learning and rigorous testing are your allies on this exciting journey into the world of decentralized finance! 🌐

## Conclusion
Constant Sum Automated Market Makers have had a significant impact on the DeFi space, enabling decentralized, permissionless trading and liquidity provision. Understanding how they work and how to implement them is a valuable skill for anyone interested in blockchain and DeFi development.

In this article, we’ve explored the inner workings of Constant Sum AMMs, their importance in the DeFi ecosystem, and provided a basic example of how to implement one using Solidity. As the DeFi landscape continues to evolve, AMMs like these will likely play an even more prominent role in shaping the future of finance.

If you’re interested in diving deeper into DeFi and AMMs, consider exploring more advanced topics like impermanent loss, multi-token AMMs, and the governance mechanisms that underpin these systems. Happy coding, and welcome to the exciting world of DeFi development! 🌐

Remember to conduct thorough research and testing before deploying any smart contracts in a production environment, as security is paramount in the world of DeFi.
