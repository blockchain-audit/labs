# Hack

## Methodology
* Tokenomics
* Finance
* Spécification
* Modeling
* Implementation high level
* Implementation Low level coding
* Testing
* Security
* Formal verification
* Audit

## Math

* Duo
* Algebra 12
* Brilliant
* Logicola
* Lean4

## Landing
- my history
- bounty opportunity
- intro blockchain [bank IT vs public network]
- why neovim  [kosher + velocity - learning curve]

### EVM

* [lean4-evm](https://github.com/DavePearce/LeanEVM/tree/main)

### Skills

* EVM opcodes
* Solidity
* Dafny
* Tokenomics
* Attack Vectors
* Oracle
* Huff
* Logic
* Testing [unit, fuzz, static, certora]
* ZK
* Tokenomics
* Math
* Finance
* Accounting
* Design Patterns
* Nodes
* Networks,

### Project

* White Paper
* User Stories
* Full Vector attacks audit
* Economical Audit [Dafny]


### Audit

We focus on economical attacks on invariants, once manual checks are done by AI pattern matching.

* Review manually all the attack vectors per function
* Map Properties and Invariants
* Write formals specs per function
* Implement  spces and functions in Dafny



## Environment

* [git](https://phoenixnap.com/kb/how-to-install-git-on-ubuntu)
* [zsh](https://phoenixnap.com/kb/install-zsh-ubuntu)
* [lean4](https://leanprover-community.github.io/install/linux.html)
* [nix](https://nixos.org/download) - install single user with --no-daemon
* [vscode](https://code.visualstudio.com/)
* [rust](https://www.rust-lang.org/tools/install)
* [golang](https://go.dev/doc/install)
* [foundry](https://book.getfoundry.sh/getting-started/installation)
* [huff](https://docs.huff.sh/get-started/installing/)


## Tools

* [evm-analytics](https://github.com/Jon-Becker/heimdall-rs)


```
ext tintinweb.solidity-visual-auditor
ext install huff-language.huff-language
ext install dafny-lang.ide-vscode
ext install golang.Go
```

## Daily Project

* [erc-20](https://eips.ethereum.org/EIPS/eip-20)
* [multi-token](https://eips.ethereum.org/EIPS/eip-1155)
* [minimal-proxy](https://eips.ethereum.org/EIPS/eip-1167)



## Routine

### Math

* Algebra
* Schoolyourself
* Brilliant
* Logicola
* Lean4


### Project

* Detail and discuss specs
* Implement [erc20, erc 721, vault, staking, farm, dao, CDP, amm]


### Coding
* Solidity
* Huff


### Audit

* Dafny
* Attack Vectors
* Protocol Mechanisms


## Folders

* huff  - huff tutorial
* dafny - dafny tutorial
* src   - [solidity, huff and dafny]





## Getting Started

### Requirements

The following will need to be installed in order to use this template. Please follow the links and instructions.

-   [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
    -   You'll know you've done it right if you can run `git --version`
-   [Foundry / Foundryup](https://github.com/gakonst/foundry)
    -   This will install `forge`, `cast`, and `anvil`
    -   You can test you've installed them right by running `forge --version` and get an output like: `forge 0.2.0 (92f8951 2022-08-06T00:09:32.96582Z)`
    -   To get the latest of each, just run `foundryup`
-   [Huff Compiler](https://docs.huff.sh/get-started/installing/)
    -   You'll know you've done it right if you can run `huffc --version` and get an output like: `huffc 0.3.0`

### Quickstart

1. Clone this repo or use template

Click "Use this template" on [GitHub](https://github.com/huff-language/huff-project-template) to create a new repository with this repo as the initial state.

Or run:

```
git clone https://github.com/huff-language/huff-project-template
cd huff-project-template
```

2. Install dependencies

Once you've cloned and entered into your repository, you need to install the necessary dependencies. In order to do so, simply run:

```shell
forge install
```

3. Build & Test

To build and test your contracts, you can run:

```shell
forge build
forge test
```

For more information on how to use Foundry, check out the [Foundry Github Repository](https://github.com/foundry-rs/foundry/tree/master/forge) and the [foundry-huff library repository](https://github.com/huff-language/foundry-huff).


## Blueprint

```ml
lib
├─ forge-std — https://github.com/foundry-rs/forge-std
├─ foundry-huff — https://github.com/huff-language/foundry-huff
scripts
├─ Deploy.s.sol — Deployment Script
src
├─ SimpleStore — A Simple Storage Contract in Huff
test
└─ SimpleStore.t — SimpleStoreTests
```


## License

[The Unlicense](https://github.com/huff-language/huff-project-template/blob/master/LICENSE)


## Acknowledgements

- [forge-template](https://github.com/foundry-rs/forge-template)
- [femplate](https://github.com/abigger87/femplate)


## Disclaimer

_These smart contracts are being provided as is. No guarantee, representation or warranty is being made, express or implied, as to the safety or correctness of the user interface or the smart contracts. They have not been audited and as such there can be no assurance they will work as intended, and users may experience delays, failures, errors, omissions, loss of transmitted information or loss of funds. The creators are not liable for any of the foregoing. Users should proceed with caution and use at their own risk._
