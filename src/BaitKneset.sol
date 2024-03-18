Yehudis
  4:13 PM
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
///@title Wallet
contract Wallet {
    address public owner;
    mapping (address => bool) public  withdraws;
    constructor() {
        owner = msg.sender;
        withdraws[msg.sender]=true;
    }
    /// @dev a function that can recieve money that was deposited to my wallet
    //this function is a builet in function
    receive() external payable {}
    /// @dev add gabaim to be able to withdraw too.
    function addWithdraws(address withdrawer) public {
        require(msg.sender == owner  );
         withdraws[withdrawer] = true;
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
