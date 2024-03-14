// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";


contract Owner {

    address private owner;

    // event for EVM logging
    event OwnerSet(address indexed oldOwner, address indexed newOwner);

    // modifier to check if caller is owner
    modifier isOwner() {
        

        //checs if the one that invites the function is the owner if not it will print "Caller is not owner"
        require(msg.sender == owner, "Caller is not owner");
        _;
    }

   
    constructor() {
        console.log("Owner contract deployed by:", msg.sender);
        owner = msg.sender; // 'msg.sender' is sender of current call, contract deployer for a constructor
        emit OwnerSet(address(0), owner);
    }

     //Change owner
     //param new owner address of new owner
     
    function changeOwner(address newOwner) public isOwner {
        emit OwnerSet(owner, newOwner);
        owner = newOwner;
    }

    //dev returns owner address 
    //returns the address of owner
     
    function getOwner() external view returns (address) {
        return owner;
    }
} 
