// SPDX-License-Identifier: Unlicense
pragma solidity >=0.5.11;

import "forge-std/Test.sol";
import "forge-std/console.sol";


//problem eve can to take from accounr alice tokens
contract contractTest is Test {
    ERC20 ERC20Contract;

}

interface IERC20{

    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amout) external returns (bool);

    //?
    function allowance(
        address owner,
        address spender 
    ) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function tranferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint amount);

}
contract ERC20 is IERC20 {
    uint public totalSupply;
    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;
    string public name =  "Test example";
    string public symbol = "Tast";
    uint public decimals = 18;

    function transfer(address recipient, uint amount) external returns (bool){
        balanceOf[msg.sender] -= amount;
        balanceOf[receipent] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    // allowing to spender spend from sender amount tokens
    function approve(address spender, uint amount) external returns (bool){
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender,amount);
        return true;
    }
    
}
