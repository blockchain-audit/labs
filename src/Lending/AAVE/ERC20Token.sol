pragma solidity ^0.8.20;

import "forge-std/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ERC20Token is ERC20 {
    function mint(address _account, uint256 _value) external {
        _mint(_account, _value);
    }

    function burn(address _account, uint256 _value) external {
        _burn(_account, _value);
    }
}
