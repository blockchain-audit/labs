// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;
import "forge-std/interfaces/IERC20.sol";

contract MyToken is IERC20 
{
    uint public totalSupply;
    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;
    address owner;

    constructor()
    {
        owner = msg.sender;
    }


    function transfer(address to, uint256 amount) external returns (bool)
    {
        balanceOf[msg.sender] -= amount;
        balanceOf[msg.sender] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function approve(address spender, uint256 amount) external returns (bool)
    {
        allowance[msg.sender][spender] += amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) external returns (bool)
    {
        allowance[from][msg.sender] -= amount;
        balanceOf[from] -= amount;
        balanceOf[to] += amount;
        return true;
    }

    /// @notice Returns the name of the token.
    function name() external view returns (string memory)
    {
        return "MyToken";
    }

    /// @notice Returns the symbol of the token.
    function symbol() external view returns (string memory)
    {
        return "chaya";
    }

    /// @notice Returns the decimals places of the token.
    function decimals() external view returns (uint8)
    {
        return 2;
    }

    function mint(address to, uint amount) external returns (bool)
    {
        require(msg.sender == owner);
        balanceOf[to] += amount;
    }
}