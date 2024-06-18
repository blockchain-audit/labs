// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import "solmate/tokens/ERC20.sol";

contract ERC20Implementation is ERC20{
    // constructor(uint256 initialBalance) ERC20("ERC20", "ERC") {
    //     _mint(msg.sender, initialBalance);
    // }

    constructor() ERC20("ERC20", "ERC", 7) {
        // _mint(msg.sender, initialBalance);
    }

    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }

}