

* [smart-contract-programmer](https://www.youtube.com/@smartcontractprogrammer)


1. **Variables and Types:**
   - `uint`, `int`, `address`, `bool`, `string`, `bytes`

2. **State Variables:**
   - `public`, `private`, `internal`, `external`

3. **Functions:**
   - `function`, `returns`, `view`, `pure`, `payable`, `modifier`

4. **Control Structures:**
   - `if`, `else`, `while`, `for`, `break`, `continue`

5. **Structs:**
   - `struct`

6. **Arrays:**
   - `array`, `mapping`

7. **Events and Logging:**
   - `event`, `emit`

8. **Modifiers:**
   - `modifier`

9. **Inheritance:**
   - `contract`, `interface`, `abstract`, `is`

10. **Visibility Specifiers:**
    - `public`, `internal`, `external`, `private`

11. **Error Handling:**
    - `require`, `revert`, `assert`, `throw`

12. **Fallback Function:**
    - `fallback`

13. **Ether Units:**
    - `wei`, `finney`, `ether`

14. **Contract Creation and Deployment:**
    - `constructor`, `new`

15. **Self-destruct:**
    - `selfdestruct`

16. **Time Units:**
    - `block.timestamp`, `now`, `block.number`, `block.difficulty`

17. **Address Related:**
    - `msg.sender`, `msg.value`, `address.balance`

18. **Modifiers for Access Control:**
    - `onlyOwner`, `onlyAdmin`, etc.

19. **Interface:**
    - `interface`

20. **Library:**
    - `library`

21. **Assembly:**
    - `assembly`, `mload`, `mstore`, `calldataload`, `calldatacopy`

22. **Fallback Function:**
    - `fallback`

This list covers many of the essential concepts in Solidity, and it can be a helpful guide for structuring a Solidity course. Depending on the level of the course (beginner, intermediate, or advanced), you can adjust the depth and complexity of each topic.


## Cheat Sheets

* [solidity-compilable](https://github.com/henry-hz/cheatsheet.sol)




## Solidity


| Topic | Explanation | Example | Complexity |
|---|---|---|---|
| **Solidity Basics** | | | |
| Hello World | Your first Solidity program, printing "Hello World" to the blockchain. | `contract HelloWorld { function sayHello() public pure { console.log("Hello World!"); } }` | Beginner |
| First App | Build a simple application like a voting system or counter. | `contract Counter { uint public count; function increment() public { count++; } }` | Beginner |
| Primitive Data Types | Understand basic data types like `uint`, `int`, `string`, and `address`. | `uint age = 25; address myAddress = msg.sender;` | Beginner |
| Variables | Declare and manage variables within your smart contracts. | `uint256 balance; mapping (address => uint256) public balances;` | Beginner |
| Constants | Define immutable values that cannot be changed after initialization. | `const MAX_SUPPLY = 10000;` | Beginner |
| Immutable | Make variables or structs unchangeable after assignment. | `immutable uint public immutableValue = 42;` | Intermediate |
| Reading and Writing to a State Variable | Interact with blockchain storage to hold persistent data. | `stateVariable = newValue;` | Beginner |
| Ether and Wei | Understand the relationship between Ether and Wei, the smallest unit of ETH. | `1 ETH = 10^18 Wei;` | Beginner |
| Gas and Gas Price | Learn about gas costs and setting appropriate gas prices for transactions. | `transaction.send(gasLimit * gasPrice);` | Intermediate |
| **Control Flow** | | | |
| If / Else | Make conditional decisions within your smart contract. | `if (value > 10) { rewardWinner(); } else { storeForNextRound(); }` | Beginner |
| For and While Loop | Iterate over data efficiently using loops. | `for (uint i = 0; i < 10; i++) { doSomething(i); }` | Beginner |
| **Data Structures** | | | |
| Mapping | Create key-value pairs to store and retrieve data dynamically. | `mapping (address => uint) public balances;` | Intermediate |
| Array | Define ordered collections of elements of the same type. | `uint[] public numbers = [1, 2, 3];` | Beginner |
| Enum | Create custom data types with a fixed set of predefined values. | `enum Status { OPEN, CLOSED, CANCELLED }` | Beginner |
| Structs | Combine multiple variables into a single unit representing complex data. | `struct Person { string name; uint age; }` | Intermediate |
| **Advanced Concepts** | | | |
| Data Locations | Understand the three data locations (storage, memory, calldata) and their usage. | `function getValue() public view returns (uint) { uint value = storageVariable; return value; }` | Intermediate |
| Function | Define reusable blocks of code with parameters and return values. | `function transfer(address recipient, uint amount) public { balances[msg.sender] -= amount; balances[recipient] += amount; }` | Intermediate |
| View and Pure Functions | Use functions that read data without modifying state or don't rely on external data. | `function getBalance(address user) public view returns (uint) { return balances[user]; }` | Intermediate |
| Error | Throw custom errors to handle unexpected situations. | `require(balance >= amount, "Insufficient funds");` | Beginner |
| Function Modifier | Extend function behavior with reusable code without code duplication. | `@payable modifier public() {}` | Intermediate |
| Events | Log data onto the blockchain for off-chain monitoring. | `event Transfer(address indexed from, address indexed to, uint value);` | Intermediate |
| Constructor | Initialize your smart contract's state when it's deployed. | `constructor(uint initialValue) public { storageVariable = initialValue; }` | Intermediate |

