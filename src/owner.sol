// SPDX-License-Identifier: MIT
//the  version of comailer
pragma solidity >=0.7.0 <0.9.0;
contract Owner {
    address private owner;
    //update the address of new addrss
    event OwnerSet(address indexed oldOwner, address indexed newOwner);
    //check if this function do by owner
    //the diffrent between modifier to function that 
    //modifier=not get paremeters and not return anythings just check in the code
    //function=can get and return
    modifier isOwner() {
        //check if address equal to owner address
        require(msg.sender == owner, "Caller is not owner");
        _;
    }
    constructor() {
        //initialization 
        owner = msg.sender;
        emit OwnerSet(address(0), owner);
    }
    //this function change the address to new address=value in the address
    function changeOwner(address newOwner) public isOwner{
        emit OwnerSet(owner, newOwner);
        owner = newOwner;
    }
    //this function return the value in address of owner
    function getOwner()external view returns(address){
        return owner;
    }
}
