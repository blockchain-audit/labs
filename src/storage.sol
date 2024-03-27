// SPDX-License-Identifier: MIT
//the  version of comailer
pragma solidity >=0.7.0 <0.9.0;
contract Storage{
// can get just postive complate number
uint256 number;
//this function change the value in parameter number.
function store(uint256 num)public{
number=num;
}
//this function return the value in parameter number.
function retrieve() public view returns (uint256){
    return  number;
}
}
