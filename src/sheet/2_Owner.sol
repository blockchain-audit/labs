
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @titel Owner

/// @dev Set & change owner

contract Owner {

    address private owner;

    // an event for EVM logging 
    //what is indexed?

    event OwnerSet(address indexed oldOwner, address indexed newOwner);
    
    //modifier to check if the caller is the owner
    //what does modifier mean?
    //a code that can be reused in a functions in the contract

    modifier isOwner(){

        require(msg.sender == owner, "Caller is not owner");
        _;
    }

/// @dev Set contract deploy as owner

constructor() {
    owner = msg.sender;
    emit OwnerSet(address(0), owner);
}

/// @dev Change owner
/// @param newOwner address of new owner 

// changing owners 
// and checking that the owner is the one who called the function
// using the modifier
function changeOwmer(address newOwner) public isOwner {
    emit OwnerSet(owner, newOwner);
    owner = newOwner;
}

/// @dev Return owner address
/// @return address of owner

//what does external mean?

function getOwner() external view returns (address){
    return owner;
}

}