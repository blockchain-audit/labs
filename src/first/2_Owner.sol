// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/// @title Owner
/// @dev Set & change Owner
contract Owner {

    address private owner;

    // event for EVM logging
    // EVM = Ethereum Virtual Machine
    // what is indexed?
    // marking variables in the function definition as "indexed"
    event OwnerSet(address indexed oldOwner, address indexed newOwner);

    // check if caller is owner
    // what is modifier?
    // modifier - reserving logic for reuse
    modifier isOwner() {
        // if the condition is true, the code will continue
        // if not, it will return the message
        require(msg.sender == owner, "Caller is not owner");
        _;
    }

    /// @dev Set contract deployer as owner
    constructor() {
        // the sender of current call
        owner = msg.sender;
        // running the function 'OwnerSet'
        // what is address(0)?
        // address(0) - Ethereum address is not initialized or does not exist
        // like null in other languages
        emit OwnerSet(address(0), owner);
    }

    /// @dev Change owner
    /// @param newOwner - address of new owner
    // what is isOwner?
    // isOwner - to ensure that only the owner can trigger the function
    // isOwner - modifier
    function changeOwner(address newOwner) public isOwner {
        // running the function 'OwnerSet'
        emit OwnerSet(owner, newOwner);
        owner = newOwner;
    }

    /// @dev Return owner address
    /// @return address of owner
    // what is external?
    // external - the function can only be called outside the contract
    function getOwner() external view returns (address) {
        return owner;
    }

}
