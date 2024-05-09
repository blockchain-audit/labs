// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract DivideContract{
    address payable public owner;
    address[] public peopleAddresses;
    uint256 public totalAddress;

    constructor() {
        totalParticipants = 0;
        owner=msg.sender;
       
     modifier onlyOwner(){
        require(
            owner == msg.sender ,
            "Only the owner allowed to distribute");
            _;
    }
    function AddAddress() external  {
        peopleAddresses.push(msg.sender);
        totalAddress++;
    }
    function Distribute(uint256 amount) external payable onlyOwner{
        require(totalAddress > 0, "No Address");
        require(totalAddress > 0, "No Address");
        uint256 amountToDistribute = amount / totalAddress; 
        for (uint256 i = 0; i < totalAddress; i++) {
            address peopleAddress = peopleAddresses[i];
            owner.transfer(peopleAddress,amountToDistribute);
        }


    }

}