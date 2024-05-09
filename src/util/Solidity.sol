// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Owner {
    //variable owner
    address private owner;

    //Registration
    event OwnerSet(address indexed oldOwner, address indexed newOwner);

    // A function that checks if it is the owner
    modifier isOwner() {
        //??
        //
        //
        require(msg.sender == owner, "Caller is not owner");
        _;
    }

    //Defines as owner
    constructor() {
        // emit LogMessage("Owner contract deployed by:", msg.sender);
        owner = msg.sender; // ?
        emit OwnerSet(address(0), owner);
    }

    //Updating the address of the new owner
    function changeOwner(address newOwner) public isOwner {
        emit OwnerSet(owner, newOwner);
        owner = newOwner;
    }

    //return address of the owner
    function getOwner() external view returns (address) {
        return owner;
    }
}
