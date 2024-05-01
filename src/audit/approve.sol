// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "@hack/like/IERC20.sol";

contract ERC20 is IERC20 {
    uint256 public supply;
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowance;
    string public name = "Test example";
    string public symbol = "Test";
    uint8 public decimals = 18;

    function balanceOf(address guy) external view returns (uint256) {
        return balances[guy];
    }

    function totalSupply() external view returns (uint256) {
        return supply;
    }

    function transfer(address recipient, uint256 amount)
    external returns (bool) {
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint256 amount)
    external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient,
                          uint256 amount) external returns (bool) {
        allowance[sender][msg.sender] -= amount;
        balances[sender] -= amount;
        balances[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function mint(uint256 amount) external {
        balances[msg.sender] += amount;
        supply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    function burn(uint256 amount) external {
        balances[msg.sender] -= amount;
        supply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}
