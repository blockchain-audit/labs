// SPDX-License-Identifier: MIT
pragma solidity >=0.5.11;

import "forge-std/console.sol";

contract Wallet {
    address public mainOwner;
    mapping(address => bool) public owners;
    uint256 public countOwners = 0;

    constructor() {
        mainOwner = msg.sender;
    }
    // https://meli.org.il/wp-content/uploads/2021/04/19-10-2020-%D7%91%D7%9C%D7%95%D7%A7%D7%A6%D7%99%D7%99%D7%9F-%D7%9E%D7%90%D7%92%D7%95%D7%A1%D7%99%D7%A1%D7%98%D7%9D-%D7%9C%D7%90%D7%A7%D7%95%D7%A1%D7%99%D7%A1%D7%98%D7%9D.pdf?&~nfopt(fileDistorted=12231389391604575)

    receive() external payable {}

    function withdraw(uint256 amount) public isOwner {
        require(payable(address(this)).balance >= amount, "Not Enough Money in wallet");
        payable(msg.sender).transfer(amount);
    }

    function addOwner(address newOwner) public {
        require(msg.sender == mainOwner, "not main owner");
        require(!owners[newOwner], "the owner already exsist");
        if (countOwners < 3) {
            countOwners++;
            owners[newOwner] = true;
        } else {
            revert("there are already 3 owners");
        }
    }

    function changeOwner(address oldOwner, address newOwner) public {
        require(msg.sender == mainOwner, "You do not have permission to do so");
        require(owners[oldOwner], "the adress oldOwner not owner");
        require(!owners[newOwner], "the new owner already owner");
        owners[oldOwner] = false;
        owners[newOwner] = true;
    }

    function balance() public view returns (uint256) {
        return address(this).balance;
    }

    modifier isOwner() {
        require(msg.sender == mainOwner || owners[msg.sender], "sender is not owner");
        _;
    }
}
