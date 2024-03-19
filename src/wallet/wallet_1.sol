// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
///@title Wallet
contract Wallet {
    address public owner;
    mapping(address => bool) public withdraws;
   uint limit;
   uint keys ;
    constructor() {
        owner = msg.sender;
        withdraws[msg.sender] = true;
        keys = 1;
    // the mapping is limited to 4 the owner and 3 gabaim
        limit=4;
    }
    /// @dev if the owner wants to change the limit
    function changeLimit(uint newLimite) public{
        limit = newLimite;
    }
    //i saw that there are a few functions that have the same require
    //it gave me a few advatages like saving gas
    modifier isOwner() {
        require(
            msg.sender == owner,
            "the owner is the only one that can call this function!"
        );
        _;
    }
    /// @dev a function that can recieve money that was deposited to my wallet
    //this function is a builet in function
    receive() external payable {}
    /// @dev add gabaim to be able to withdraw too.
    function addWithdraws(address withdrawer) public isOwner {
        require(keys < limit, "you've passed the limit ");
        keys++;
        withdraws[withdrawer] = true;
    }
    /// @dev a function to change  a withdrawer
    function changeWithdraws(address withdraweToChange, address newWithdraw)
        public
        isOwner
    {
        delete withdraws[withdraweToChange];
        withdraws[newWithdraw] = true;
    }
    /// @dev a function to delete a withdraw
    function deleteWithdraws(address withdraweToDelete) public isOwner {
       keys--;
        delete withdraws[withdraweToDelete];
    }
    /// @dev a function for the owner to withdraw mony from the wallet
    /// @param withdrawAmount a uint for the amount of eth to withdraw
    function withdraw(uint256 withdrawAmount) public {
  require(withdraws[msg.sender], "WALLET-not-allowed");
        require(
            address(this).balance >= withdrawAmount,
            "not enough eth to withdraw"
        );
          payable(msg.sender).transfer(withdrawAmount);
        // the balanc is updatet automatically
    }
    /// @dev a function to view the wallets balance
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}