// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Wallet1 {
    address payable public owner;
    mapping(address => bool) gabaim;

    constructor(
        address gabai1,
        address gabai2,
        address gabai3
    ) {
        owner = payable(msg.sender);
        gabaim[gabai1] = true;
        gabaim[gabai2] = true;
        gabaim[gabai3] = true;
    }

    receive() external payable {}

    function withdraw(uint256 amount) external {
        require(
            owner == msg.sender || gabaim[msg.sender] == true,
            "wallet is not owner or an allow user "
        );
        payable(msg.sender).transfer(amount);
       
    }

    function changeOwner(address oldAddress, address newAddress) public {
        require(owner == msg.sender, "only owner can change gabaim");
        gabaim[oldAddress]=false;
        gabaim[newAddress]=true;

    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
