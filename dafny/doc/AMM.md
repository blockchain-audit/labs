
## CSAMM Smart Contract Properties for Formal Verification

| Property Name | Category | Informal Description |
|---|---|---|
| Invariant: Balances | State | `ΣbalanceOfaddress: token0 + ΣbalanceOfaddress: token1 == totalSupply * token0.decimals()` |
| Pre-condition: Swap | Function | `_amountIn > 0` and `_tokenIn ∈ {address(token0), address(token1)}` |
| Post-condition: Swap | Function | `reserve0 * reserve1 * (1 - fee/1000) == (reserve0_pre * reserve1_pre)` (where `_pre` denotes pre-swap values) |
| Invariant: Total Supply | State | `totalSupply == ΣbalanceOfaddress: liquidityToken` |
| Pre-condition: Add Liquidity | Function | `_amount0 > 0` and `_amount1 > 0` |
| Post-condition: Add Liquidity | Function | `shares * (reserve0 + reserve1) / totalSupply == _amount0 + _amount1` |
| Pre-condition: Remove Liquidity | Function | `_shares ≤ balanceOfmsg.sender: liquidityToken` |
| Post-condition: Remove Liquidity | Function | `d0 + d1 == _shares * (reserve0 + reserve1) / totalSupply` and `token0.balanceOf(msg.sender) += d0 - fee0` and `token1.balanceOf(msg.sender) += d1 - fee1` (where `fee0` and `fee1` represent potential fees) |
| Loop Invariant: Update Reserves | Internal Function | `(reserve0_new * reserve1_new) == (reserve0_pre * reserve1_pre)` during reserve updates |

**Note:**

* The `decimals()` function depends on the specific ERC20 token implementation.
* Fees have been simplified for clarity. Actual implementation might involve more complex fee structures.


## Invariants

### Token Balance Consistency
∀ token: balanceOf[token] + token.balanceOf(address(this)) == token.totalSupply()


### Liquidity Proportional Shares
∀ _amount0, _amount1: (d0 + d1) * totalSupply / (reserve0 + reserve1) == shares


## Ensures

### Non-negative Shares

shares > 0


### Token Transfer Consistency
∀ tokenOut: tokenOut.balanceOf(msg.sender) == tokenOut.balanceOf(address(this)) - amountOut


### Liquidity Adjustment Consistency
reserve0 - d0 == token0.balanceOf(address(this)) && reserve1 - d1 == token1.balanceOf(address(this))


### Token Transfer Balance

token0.balanceOf(msg.sender) == previousToken0Balance + d0 && token1.balanceOf(msg.sender) == previousToken1Balance + d1






