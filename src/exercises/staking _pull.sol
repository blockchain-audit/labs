// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;
import "forge-std/console.sol";

contract Staking_pool{
mapping(address=>uint256)public date_deposit;
constructor () {}
receive() external payable { 
    date_deposit[msg.sender]=block.timestamp;
    console.log('address',msg.sender, 'time',block.timestamp);
}
function withDraw(uint256 amount)public{
 
}


}