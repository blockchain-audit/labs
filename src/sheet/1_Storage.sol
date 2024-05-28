// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title Storage
//dev is what we are developing now
/// @dev Store & retrieve value in a variable

contract Storage {

    uint256 number;

/// @dev Store value in variable
/// @param num value to store

function store (uint256 num) public {

    //storing the number we got in to number
    number = num;
}

/// @dev Return value 
/// @return value of number

//what does view mean?

function retrieve() public view returns (uint256){
    return number;
}


}
