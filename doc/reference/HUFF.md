

## Stack Manipulation

```
POP     (0x50):         Remove the top item from the stack.
PUSH[x] (0x60 to 0x7f): Pushes a 1 to 32-byte immediate value onto the stack.    [1-32]
DUP [x] (0x80 to 0x8f): Duplicate the nth from the top of the stack and push it  [1-16]
SWAP[x] (0x90 to 0x9f): Swap the top of the stack with the nth item from the top [1-16]
```


## Memory Operations

```
MLOAD   (0x51): Load a 32-byte word from memory.
MSTORE  (0x52): Store a 32-byte word to memory.
MSTORE8 (0x53): Store a single byte to memory.
```

### Mnemonic

```asm
// 1 byte = 8 bits | 32 bytes = 256 bits

PUSH2 0x1000  // VALUE TO STORE
PUSH1 0x00    // POINTER [0]
MSTORE

//00000000000000000000000000000000
//00000000000000000000000000001000

PUSH1 0x05    // VALUE TO STORE
PUSH1 0x20    // POINTER [32]
MSTORE

//00000000000000000000000000000000
//00000000000000000000000000001000
//00000000000000000000000000000000
//00000000000000000000000000000005

PUSH1 0x1F     // VALUE TO STORE
PUSH1 0x40     // POINTER [64]
MSTORE

PUSH1 0x20
MLOAD
```

### Binary
```binary
6110006000526005602052601f604052602051
```


## Contract Calls

- not-expandable
- can't be overwritten
- included transaction payload
- input for contract calls


```
CALLVALUE    (0x34): Retrieves the value (ether) sent along with the message or transaction.
CALLDATALOAD (0x35): Loads a 32-byte word from the input data.
CALLDATASIZE (0x36): Retrieves the size of the input data (message data).
CALLDATACOPY (0x37): Copies input data to a specified memory location.
```

Add

```
PUSH1 0x00
CALLDATALOAD
PUSH1 0x20
CALLDATALOAD
ADD
PUSH1 0x00
MSTORE
PUSH1 0x20
PUSH1 0x00
RETURN
```


## Storage Operations

```
SLOAD  (0x54): Load a 32-byte word from storage.
SSTORE (0x55): Store a 32-byte word to storage.
```


## Arithmetic Operations


```
ADD        (0x01): Addition.
MUL        (0x02): Multiplication.
SUB        (0x03): Subtraction.
DIV        (0x04): Division.
SDIV       (0x05): Signed Division.
MOD        (0x06): Modulo.
SMOD       (0x07): Signed Modulo.
ADDMOD     (0x08): Addition Modulo.
MULMOD     (0x09): Multiplication Modulo.
EXP        (0x0a): Exponential operation.
SIGNEXTEND (0x0b): Sign extension.
```

## Comparison Operations

```
LT (0x10): Less Than.
GT (0x11): Greater Than.
SLT (0x12): Signed Less Than.
SGT (0x13): Signed Greater Than.
EQ (0x14): Equal.
ISZERO (0x15): Check if equal to zero.
```


## Bitwise Logic Operations

```
AND (0x16): Bitwise AND.
OR (0x17): Bitwise OR.
XOR (0x18): Bitwise XOR.
NOT (0x19): Bitwise NOT.
```

## Bitwise Shift Operations

```
BYTE (0x1a): Retrieve a byte from a larger value.
SHL (0x1b): Shift Left.
SHR (0x1c): Logical Shift Right.
SAR (0x1d): Arithmetic Shift Right.
```

## Hashing Operation

```
KECCAK256 (0x20): Keccak-256 hash function.
```


## Contract Information

```
ADDRESS  (0x30): Retrieves the address of the current contract.
CODESIZE (0x38): Retrieves the size of the code of the current contract.
CODECOPY (0x39): Copies code to a specified memory location.
```


## Information Retrieval

```
BALANCE  (0x31): Retrieves the balance of a specified address.
```


## Return

```
RETURNDATASIZE (0x3d): Retrieves the size of the return data.
RETURNDATACOPY (0x3e): Copies return data to a specified memory location.
```


## Transaction

```
GASPRICE    (0x3a): Retrieves the gas price of the transaction.
ORIGIN      (0x32): Retrieves the origin address of the transaction.
CALLER      (0x33): Retrieves the caller (sender) of the message or transaction.
```

## External Code

```
EXTCODESIZE (0x3b): Retrieves the size of the code of an external account.
EXTCODECOPY (0x3c): Copies the code of an external account to a specified memory location.
EXTCODEHASH (0x3f): Retrieves the hash of the code of an external account.
```


## Block Information Retrieval

```
BLOCKHASH   (0x40): Retrieves the hash of a specific block.
COINBASE    (0x41): Retrieves the address of the block's miner (coinbase address).
TIMESTAMP   (0x42): Retrieves the timestamp of the current block.
NUMBER      (0x43): Retrieves the block number.
DIFFICULTY  (0x44): Retrieves the difficulty of the current block.
GASLIMIT    (0x45): Retrieves the gas limit of the current block.
BASEFEE     (0x48): Retrieves the base fee of the current block.
```


## Chain Information Retrieval

```
CHAINID     (0x46): Retrieves the current chain ID.
```

## Balance Retrieval

```
SELFBALANCE (0x47): Retrieves the balance of the current contract address.
```



## Control Flow Operations

```
JUMP     (0x56): Unconditional jump to a destination.
JUMPI    (0x57): Conditional jump to a destination.
JUMPDEST (0x5b): Mark a valid jump destination.
```

## Information Retrieval Operations

```
PC       (0x58): Get the program counter.
MSIZE    (0x59): Get the size of the active memory.
GAS      (0x5a): Get the remaining gas.
```

## Storage

```
SLOAD  (0x54): Loads a 32-byte word from storage into the stack.
SSTORE (0x55): Stores a 32-byte word to storage.
```


## Flow Control

```
JUMP     (0x56): Jumps to a destination address unconditionally.
JUMPI    (0x57): Jumps to a destination address if the top stack item is nonzero.
JUMPDEST (0x5b): Marks a destination for jumps.
```


## Logging Operations

The number in the opcode indicates the number of items to be logged (0 to 4). The actual data to be logged is taken from the stack.

```
LOG0 to LOG4 (0xa0 to 0xa4): Record a log entry.
```


## Contract Creation

```
CREATE  (0xf0): Creates a new contract with the given bytecode.
CREATE2 (0xf5): Creates a new contract with a salt and bytecode, with deterministic deployment.
```

## Contract Interaction

```
CALL         (0xf1): Calls another contract with a specified gas, value, and input data.
CALLCODE     (0xf2): Similar to CALL, but execute in the context of the calling contract.
DELEGATECALL (0xf4): Similar to CALLCODE, but preserves the caller's context.
STATICCALL   (0xfa): Similar to CALL, but only executes code and does not modify state.
```


## Halt Execution

```
RETURN (0xf3): Halts execution and returns data from the current contract to the caller.
REVERT (0xfd): Halts execution, reverts state changes, and returns data to the caller.
STOP   (0x00): Stop execution
```

## Exception Handling and Termination

```
INVALID (0xfe): Marks the execution as invalid.
SELFDESTRUCT (0xff): Destroys the current contract, sending remaining funds to a specified address.
```
