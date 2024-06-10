// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract Counter{
    uint256 public count;


function get() public view returns (uint){
    return count;
}

function inc() public {
    return count+=1;
}

function dec() public {
     return count-=1;
}
}