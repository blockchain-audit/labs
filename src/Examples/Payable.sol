// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract Payable {
    address payable public owner;

    constructor() payable {
        owner = payable(msg.sender);
    }

    function deposit() public payable {}
    function notPayable() public {}

    function withdraw() public {
        uint256 amount = address(this).balance;
        (bool success,) = owner.call{value: amount}("");
        require(success, "Failed to send Ether");
    }

    function transfer(address payable _to, uint256 _amount) public {
        (bool success,) = _to.call{value: _amount}("");
        require(success, "Failed to send Ether");
    }
}
