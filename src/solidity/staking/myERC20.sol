
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
//import "@openzeppelin/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
//import "@openzeppelin/ERC20/extensions/ERC20Permit.sol";

contract MyToken is ERC20{

 constructor() ERC20("MyToken", "MTK") {
        //this;
    }

    function mint(address myAddress, uint amount) public {
        _mint(myAddress, amount);
    }
}