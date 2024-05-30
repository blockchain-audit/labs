// SPDX-License-Identifier: GPL-3.0
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;
///@title
contract Wallet {
    address payable public owner;
    uint256 counter = 0;
    bool public isGabay;
    mapping(address => bool) public gabayim;
    constructor() {
        owner = payable(msg.sender); // 'msg.sender' is sender of current call
    }
    receive() external payable {}
    modifier isOwner() {
        require(msg.sender == owner, "caller is not owner");
        _;
    }
    function addGabay(address gabay) public isOwner {
        require(counter < 3, "There are too many collectors");
        require(gabayim[gabay]==fals"This address is already registered as a collector")
        gabayim[gabay] = true;
        counter++;
    }
    function withdraw(uint256 amount) external {
        require(
            msg.sender == owner || gabayim[msg.sender] == true,
            "caller is not allowed"
        );
        require(
            (msg.sender).balance >= amount,
            "The amount of money in the wallet is too low."
        );
        payable(msg.sender).transfer(amount);
    }
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
    function deleatGabay(address gabay) external isOwner {
        require(gabayim[gabay] == true, "The address is not that of a debt collector");
        gabayim[gabay] = false;
        counter--;
    }
}