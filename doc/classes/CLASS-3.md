
## Environment

* https://remix.ethereum.org
* https://metamask.io/
* https://learnxinyminutes.com/docs/solidity/
* clone: https://github.com/blockchain-audit/cheatsheet.sol
* add mumbai https://chainlist.org/?testnets=true&search=mumbai




## Solidity Reference

* https://topmonks.github.io/solidity_quick_ref/
* https://zerotomastery.io/cheatsheets/solidity-cheat-sheet/
* https://github.com/blockchain-audit/labs/blob/master/doc/solidity/cheat-sheet.pdf


## Transactions


* https://etherscan.io/tx/0xbf951204c517dc7a832932bfca0a2d140a717c30c94cf664021605b4bca6f052
* https://etherscan.io/tx/0x99b65098d89234d8b4487ed4d90ab22ef2869619c4a1d204895af18051eaa484

* https://eth-converter.com/extended-converter.html


* https://www.evm.codes


## Gas

22111 nekudot * 0.000000046385603269 ETH  = 0.001025632073880859 ETH


## https://etherscan.io/tx/0x99b65098d89234d8b4487ed4d90ab22ef2869619c4a1d204895af18051eaa484

On Mar-12-2024 12:34:11 PM +UTC, 0xf1c7e1...fb1dcb8b called `getReward()` on 0x490681...64583048. The transaction succeeded and incurred a fee of 0.0031 ETH.

https://dashboard.tenderly.co/tx/mainnet/0x99b65098d89234d8b4487ed4d90ab22ef2869619c4a1d204895af18051eaa484?trace=0


msg.sender = 0xF1C7e19A34cad5C49a79DcDEa2406668Fb1Dcb8B



In Solidity, a constructor is a special function that is executed only once when the contract is deployed to the Ethereum blockchain. It is used to initialize the contract's state variables or perform any one-time setup tasks.

Here are some key points about constructors in Solidity:

1. **Name**: Unlike other functions in Solidity, constructors do not have a name. Instead, they are identified by the absence of the `function` keyword and the fact that they have the same name as the contract.

2. **Visibility**: Constructors cannot have any visibility modifiers such as `public`, `private`, or `internal`. They are inherently public and can be called by anyone at the time of deployment.

3. **Execution**: The constructor is executed only once, at the time of deployment of the contract to the Ethereum blockchain. After the contract is deployed, the constructor cannot be called or executed again.

4. **Initialization**: Constructors are commonly used to initialize state variables within the contract. This allows developers to set initial values for the contract's state variables or perform any required setup operations.

5. **Gas Costs**: Executing the constructor incurs gas costs, which are paid by the user deploying the contract. It's essential to keep constructor execution efficient, especially in cases where complex operations are involved.

Here's a basic example of a constructor in Solidity:

```solidity
pragma solidity ^0.8.0;

contract MyContract {
    uint256 public myVariable;

    // Constructor
    constructor(uint256 initialValue) {
        myVariable = initialValue;
    }
}
```

In this example:
- The `MyContract` contract has a state variable `myVariable` of type `uint256`.
- The constructor sets the initial value of `myVariable` to the value passed as an argument during contract deployment.
- The constructor has no explicit visibility specifier and is therefore implicitly `public`.





```
balances[msg.sender] += msg.value;

is the same as

balances[msg.sender] = balances[msg.sender] + msg.value;
```
