// SPDX-License-Identifier: Unlicense
pragma solidity >=0.5.11;

import "forge-std/Test.sol";
import "forge-std/console.sol";

contract contractTest is Test {
    ERC20 ERC20Contract;

}

interface IERC20{

    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    
}
contract ERC20 is IERC20 {

}
