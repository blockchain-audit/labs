// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "../../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "../../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
contract Bond is ERC20 {
    constructor() ERC20("Bond", "BND") {}
    function mint(address add, uint256 amount) public {
        _mint(add, amount);
    }
    function burn(address account, uint256 value) public {
        _burn(account, value);
    }
}