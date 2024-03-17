
// SPDX-License-Identifier: GPL-3.0
 
/**
 * @title Strong
 * @dev Store & retrieve value in a varible
 */

//Specifies the version of the Solidity compiler to use to compile the contract
 pragma solidity ^0.6.6;

//The definition contract named Strong
 contract Strong{
//uint256 - An unsigned integer type variable with 256 bits of storage.
uint256 number;
//The function is public -   This function is public, it can be called outside the contract.

//the operation of the function: Updates the value of number to any integer value passed as an argument to the store function
function store(uint256 num) public{
    number = num;
}
//view - change state variable indicating that the function will not change the state of the contract
//The function returns a number of type uint256(unsigned integer value)

//The operation of the function: Allows to retrieve the last stored value of number without changing it
//is marked as view which indicates that it does not change the state of the contract
function retrieve() public view returns(uint256){
    return number;
}
 }