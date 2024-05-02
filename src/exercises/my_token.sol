// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;
import "forge-std/console.sol";
import "forge-std/interfaces/IERC20.sol";

contract MyToken is IERC20{
uint256 public totalSupply;
mapping (address=>uint256)public balanceOf;
mapping(address => mapping(address => uint)) public allowance;
address public owner;
//  string name="my Token";
    constructor(){
        owner=msg.sender;
       // balanceOf[msg.sender]=10**6;
    }
    function transfer(address to, uint256 amount) external returns (bool){
        balanceOf[msg.sender]-=amount;
        balanceOf[to]+=amount;
        emit Transfer(msg.sender,to,amount);
        return true;
    }
    function approve(address spender, uint256 amount) external returns (bool){
       allowance[msg.sender][spender]=amount;
        emit Approval(msg.sender,spender,amount);
        return true;  
    }
    function transferFrom(address from, address to, uint256 amount) external returns (bool){
        allowance[from][msg.sender]-=amount;
        balanceOf[from]-=amount;
        balanceOf[to]+=amount;
        emit Transfer(from,to,amount);
        return true;
    }
    //הנפקת מטבע
    function mint (uint256 amount,address acount)external {
        balanceOf[msg.sender]+=amount;
        totalSupply+=amount;
        emit Transfer(acount, msg.sender, amount);

    }
   
     modifier onlyOwner {
        require(msg.sender == owner, "Only the owner can call this function");
        console.log('mint',msg.sender);
        _;
    }
    //שריפת מטבע 
    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
    function name() external pure returns (string memory){
        return "ygg";
    }

    // / @notice Returns the symbol of the token.
    function symbol() external pure returns (string memory){
        return "Coin";
    }

    /// @notice Returns the decimals places of the token.
    function  decimals() external pure returns (uint8){
        return 7;
    }
}


