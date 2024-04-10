pragma solidity ^0.8.20;

import "forge-std/console.sol";
import {Test, console} from "forge-std/Test.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract MyToken is ERC20 {
    constructor() ERC20("MyToken", "MTK") {
        //this;
    }

    /*constructor(uint initialBalance) ERC20("MyToken", "MTK"){
        _mint(msg.sender, initialBalance);
    }*/

    function mint(address myAddress, uint amount) public {
        _mint(myAddress, amount);
    }
}
