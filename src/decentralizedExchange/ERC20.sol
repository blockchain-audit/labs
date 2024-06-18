// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract MyERC20 is ERC20{
    constructor(uint256 initialBalance) ERC20("ERC20", "ERC") {
        _mint(msg.sender, initialBalance);
    }

    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }

}