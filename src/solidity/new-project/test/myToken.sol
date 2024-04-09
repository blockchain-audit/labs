pragma solidity ^0.8.20;

import "forge-std/console.sol";
import {Test, console} from "forge-std/Test.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
//import "src/solidity/new-project/src/myToken.sol";

contract myTokenTest is ERC20 {
    //myToken public MyToken;
    constructor(uint initialBalance) ERC20("MyToken", "MTK") {
        _mint(msg.sender, initialBalance);
    }
}