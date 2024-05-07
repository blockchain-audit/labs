// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.2
pragma solidity ^0.8.24;

import "../../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "../../lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Permit.sol";
contract Token1 is ERC20 {
    constructor() ERC20("Token1", "T1") {
    }
    function mint(address add, uint amount) public {
        _mint(add , amount);
    }
}