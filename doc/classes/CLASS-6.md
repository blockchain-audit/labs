


```
sed -i 's/17/6/g' store.sol
```


## Solc Outputs

Solc, short for Solidity Compiler, is the standard compiler for the Solidity programming language used for writing smart contracts on the Ethereum blockchain. When you compile a Solidity source file (.sol) using solc, it produces various output files and information, depending on the command options and settings. Here are some common components of solc output:

1. **Bytecode**: The primary output of solc is the bytecode generated for the Ethereum Virtual Machine (EVM). This bytecode is the compiled version of the smart contract written in Solidity. It's what gets deployed to the Ethereum network.

2. **ABI (Application Binary Interface)**: Along with the bytecode, solc produces the ABI, which defines the interface of the smart contract. The ABI specifies the functions, events, and data structures exposed by the contract, allowing other contracts or external applications to interact with it.

3. **Optimization Information**: Solc provides optimization options that can be used to optimize the bytecode for gas efficiency or size reduction. The output may include information about the optimization settings applied during compilation.

4. **Compiler Warnings and Errors**: If there are any issues with the Solidity source code, such as syntax errors or warnings about potentially unsafe or inefficient code, solc will output diagnostic messages to alert the developer.

5. **AST (Abstract Syntax Tree)**: Solc can generate an Abstract Syntax Tree representation of the Solidity code. This is a structured representation of the code's syntax and semantics, which can be useful for analysis and tooling purposes.

6. **Source Map**: Solc can generate a source map that maps the compiled bytecode back to the original Solidity source code. This mapping is helpful for debugging and verifying the correctness of the compiled code.

7. **Metadata**: Solc can include metadata about the compilation, such as the version of the compiler used, the source files included, and other relevant information. This metadata can be useful for auditing and verifying the compiled output.

Overall, solc output consists of bytecode, ABI, optimization information, compiler messages, and optional features like AST, source maps, and metadata. These components collectively provide developers with the necessary information to deploy, interact with, and verify the correctness of their Solidity smart contracts.


## Output Options

Output Components:
  --ast-compact-json   AST of all source files in a compact JSON format.
  --asm                EVM assembly of the contracts.
  --asm-json           EVM assembly of the contracts in JSON format.
  --opcodes            Opcodes of the contracts.
  --bin                Binary of the contracts in hex.
  --bin-runtime        Binary of the runtime part of the contracts in hex.
  --abi                ABI specification of the contracts.
  --ir                 Intermediate Representation (IR) of all contracts
                       (EXPERIMENTAL).
  --ir-optimized       Optimized intermediate Representation (IR) of all
                       contracts (EXPERIMENTAL).
  --ewasm              Ewasm text representation of all contracts
                       (EXPERIMENTAL).
  --hashes             Function signature hashes of the contracts.
  --userdoc            Natspec user documentation of all contracts.
  --devdoc             Natspec developer documentation of all contracts.
  --metadata           Combined Metadata JSON whose Swarm hash is stored
                       on-chain.
  --storage-layout     Slots, offsets and types of the contract's state
                       variables.

```
solc --bin store.sol

608060405234801561001057600080fd5b50610150806100206000396000f3fe608060405234801561001057600080fd5b50600436106100365760003560e01c8063209652551461003b5780635524107714610059575b600080fd5b610043610075565b60405161005091906100d9565b60405180910390f35b610073600480360381019061006e919061009d565b61007e565b005b60008054905090565b8060008190555050565b60008135905061009781610103565b92915050565b6000602082840312156100b3576100b26100fe565b5b60006100c184828501610088565b91505092915050565b6100d3816100f4565b82525050565b60006020820190506100ee60008301846100ca565b92915050565b6000819050919050565b600080fd5b61010c816100f4565b811461011757600080fd5b5056fea2646970667358221220b953d2645d73a566649fedc7c53d57d99dbf6b36341c280ddb5a8d95eaef4f9d64736f6c63430008060033
```


```bash
solc --abi store.sol

echo '[{"inputs":[],"name":"getValue","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"newValue","type":"uint256"}],"name":"setValue","outputs":[],"stateMutability":"nonpayable","type":"function"}]' | jq

```

### Output

```json
[
  {
    "inputs": [],
    "name": "getValue",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "newValue",
        "type": "uint256"
      }
    ],
    "name": "setValue",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  }
]
```


## Hexa to Binary


To convert the hexadecimal bytes `60806040` into binary and decimal representation, we first need to split it into pairs of hexadecimal digits, then convert each pair to binary, and finally to decimal.

1. **Hexadecimal to Binary Conversion**:
   - 60: 0110 0000
   - 80: 1000 0000
   - 60: 0110 0000
   - 40: 0100 0000

2. **Binary to Decimal Conversion**:
   - 60: 0110 0000 = 2^5 + 2^6 = 32 + 64 = 96
   - 80: 1000 0000 = 2^7 = 128
   - 60: 0110 0000 = 2^5 + 2^6 = 32 + 64 = 96
   - 40: 0100 0000 = 2^6 = 64

So, in decimal, `60806040` represents the following bytes:
- Byte 1: 96
- Byte 2: 128
- Byte 3: 96
- Byte 4: 64

Therefore, `60806040` in binary is `0110 0000 1000 0000 0110 0000 0100 0000`, and in decimal, it corresponds to the values `{96, 128, 96, 64}`.


## From 0 to 255

To convert hexadecimal numbers from `0x00` to `0xFF` to decimal and binary:

1. **Decimal Conversion**:
   - `0x00`: Decimal = 0
   - `0x01`: Decimal = 1
   - `0x02`: Decimal = 2
   - ...
   - `0xFE`: Decimal = 254
   - `0xFF`: Decimal = 255

2. **Binary Conversion**:
   - `0x00`: Binary = `0000 0000`
   - `0x01`: Binary = `0000 0001`
   - `0x02`: Binary = `0000 0010`
   - ...
   - `0xFE`: Binary = `1111 1110`
   - `0xFF`: Binary = `1111 1111`

Explanation:

- Each hexadecimal digit corresponds to 4 binary digits (bits). Therefore, `0x00` corresponds to `0000 0000` in binary, and `0xFF` corresponds to `1111 1111` in binary.
- Decimal values are calculated by multiplying each hexadecimal digit by the corresponding power of 16 and summing the results. For example, `0xFF` corresponds to `15*16^1 + 15*16^0 = 255` in decimal.
- The range from `0x00` to `0xFF` covers all possible combinations of 8 bits, resulting in decimal values ranging from 0 to 255. This range is often used to represent a byte, which is the smallest addressable unit of memory in most computer architectures.


In Solidity, the `int256` type represents a signed 256-bit integer. When converting hexadecimal numbers from `0x00` to `0xFF` to decimal and binary in the context of `int256`, we interpret the hexadecimal numbers as signed integers.

Here are the conversions:

1. **Decimal Conversion**:
   - `0x00`: Decimal = 0
   - `0x01`: Decimal = 1
   - `0x02`: Decimal = 2
   - ...
   - `0x7F`: Decimal = 127 (positive)
   - `0x80`: Decimal = -128 (negative)
   - `0xFF`: Decimal = -1 (negative)

2. **Binary Conversion**:
   - `0x00`: Binary = `0000 0000`
   - `0x01`: Binary = `0000 0001`
   - `0x02`: Binary = `0000 0010`
   - ...
   - `0x7F`: Binary = `0111 1111` (positive)
   - `0x80`: Binary = `1000 0000` (negative)
   - `0xFF`: Binary = `1111 1111` (negative)

Explanation:

- For positive numbers (`0x00` to `0x7F`), the binary representation is straightforward as it is similar to the unsigned integer representation.
- For negative numbers (`0x80` to `0xFF`), we interpret the highest bit (most significant bit) as the sign bit. If it's 0, the number is positive; if it's 1, the number is negative. Then, we apply two's complement to get the magnitude of the negative number.
- For example, `0x80` represents -128 in decimal. The binary representation `1000 0000` indicates a negative number, so we apply two's complement to get the magnitude: invert all the bits and add 1. After inversion and addition, we get `0111 1111` which represents 127 in decimal. Thus, `0x80` represents -128 in decimal when interpreted as an `int256` in Solidity. Similarly, `0xFF` represents -1 in decimal.



* [decompile](https://app.dedaub.com/decompile)
* [branching-model](https://nvie.com/posts/a-successful-git-branching-model/)


## Deploy to Anvil

Anvil is started with the `anvil` code, on generally `localhost:8545`, and `forge create` has a defaut pointer to this address.

```
~/hack main* ❯ forge create --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 Store                    13:36:55
[⠊] Compiling...
No files changed, compilation skipped
Deployer: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
Deployed to: 0x5FbDB2315678afecb367f032d93F642f64180aa3
Transaction hash: 0xe9286e701a884d75b90301c4b55e31928296664a979e22b10eab3f1c74fe4eff
```

* https://hackmd.io/@FranckC/r1Rvvg4rp



## Metamask in Command Line


### cast wallet new-mnemonic

Create new 12 private key originator in form of 12 words. Every mnemonic can derive 255 wallets [private key]

```
cast wallet new-mnemonic

Successfully generated a new mnemonic.
Phrase:
capital wall slam angry click pill until blanket body cover avoid hockey

Accounts:
- Account 0:
Address:     0x1B2c9C028B21Cf146dB007e08d325753D3605d8d
Private key: 0x23e8e2565ab9366aba4c41e6cfa56c34ec65b40ef152d9c269a21d12512853e6
```

### cast derive

You can add the index you want to have your wallet derived, in this case bellow I choosed `2`.

```
cast wallet derive-private-key "capital wall slam angry click pill until blanket body cover avoid hockey" 2

- Account:
Address:     0x1B2c9C028B21Cf146dB007e08d325753D3605d8d
Private key: 0x23e8e2565ab9366aba4c41e6cfa56c34ec65b40ef152d9c269a21d12512853e6
```

### forge create

```
forge create --private-key 0x23e8e2565ab9366aba4c41e6cfa56c34ec65b40ef152d9c269a21d12512853e6 Store                    14:57:32
[⠊] Compiling...
No files changed, compilation skipped
Deployer: 0x1B2c9C028B21Cf146dB007e08d325753D3605d8d
Deployed to: 0x640c20bAF00f251825ca343d7A4045C9Da5AeA72
Transaction hash: 0xceb9ecab63bafa30f32ddfe0ad00b00747f0eaeeead3c2cd206ed76e24dc0d3e
```

