// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/interfaces/IERC20.sol";
contract MyToken is IERC20 {

    uint public totalSupply;
    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;
    string public name = "Dai";
    function transfer(address to, uint256 amount) external returns (bool)
    {
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        emit Transfer(msg.sender, to, amount);     
        return true;  
    }

    function approve(address spender, uint256 amount) external returns (bool)
    {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) external returns (bool)
    {
        allowance[from][msg.sender] -= amount;
        balanceOf[from] -= amount;
        balanceOf[to] += amount;
        emit Transfer(from, to, amount);
        return true;
    }

    function symbol() external view returns (string memory)
    {
        return "";
    }

    function decimals() external view returns (uint8)
    {
        return 5;
    }

    function mint(address to, uint amount) external
    {
        totalSupply += amount;
        balanceOf[to] += amount;
    }

}