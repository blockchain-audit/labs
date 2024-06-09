// SPDX-License-Identifier: MIT
pragma solidity >=0.5.11;

import "openzeppelin-tokens/ERC20/ERC20.sol";

contract ERC4626 is ERC20{

    event Deposit(address indexed caller , address indexed owner, uint assets,uint shares);

    event Withdraw(
        address indexed caller,
        address indexed reciver,
        address indexed owner,
        uint assets,
        uint shares
    )

    ERC20 public immutable erc20;

    constructor (ERC20  _erc20,string memory _name, string memory symbol)
    ERC20(_name,symbol,_erc20.decimals()){
        erc20 = _erc20;
    }

    function deposit(uint amountErc20, address receiver) public returns(uint shares){
        
    }

}