// Declare compiler version
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// We can use 3 slashes for documentation

///@title SimpleBank
///@author Miri Tenenboim

// constract is like a class in other languages
contract SimpleBank {
    // Static variables are defined outside the function
    // what is state variable?
    // a state variable is a variable that is permanently stored on the Ethereum blockchain
    // They exist throughout the contract

    // mapping addresses to balance by dictionary
    // mapping - saving data
    // For example - balance[address] = 100;
    // balance instead of address is equal to 100

    // Private means that there is access to the variable only in the current contract
    // Data is still viewable to other parties on blockchain

    // key = address
    // value = uint
    mapping(address => uint256) private balances;

    // Public means that all the other contracts can read the information but not change it
    address public owner;

    // Events - declaration of action to all the contract
    event LogDepositMade(address accountAddress, uint256 amount);

    // Constructor - can receive one or many variables
    // What do you mean only one allowed?
    // Constructor can receive arguments,
    // but there can only be one constructor in a contract
    // We don't need to write public because it's the default
    constructor() {
        // msg - the message that sent to the constract
        // msg.sender - the address of constract caller

        owner = msg.sender;
    }

    /// @notice Deposit ether into bank
    /// @return The balance of the user's account after the transfer of the money
    // payable - can get a value
    function deposit() public payable returns (uint256) {
        // require - We will continue with the code only if the condition is met

        // We will make sure that there will be no deviation after the transfer is made
        require((balances[msg.sender] + msg.value) >= balances[msg.sender]);

        balances[msg.sender] += msg.value;

        // with state variable we don't need to write this ot self
        // all values initial by default

        // What does emit do?
        // emit - used to trigger and log events
        emit LogDepositMade(msg.sender, msg.value);

        return balances[msg.sender];
    }

    /// @notice Withdraw ether from bank
    /// @dev Does not return excess
    /// @param withdrawAmount amount you want to withdraw
    /// @return remainingBal
    function withdraw(uint256 withdrawAmount)
        public
        returns (uint256 remainingBal)
    {
        require(withdrawAmount <= balances[msg.sender]);

        balances[msg.sender] -= withdrawAmount;

        // The updated balance is returned
        payable(msg.sender).transfer(withdrawAmount);

        return balances[msg.sender];
    }

    /// @notice Get balance
    /// @return The balance of the user
    // view - prevents function from editing state variables
    // allows function to run locally/off blockchain
    function balance() view public returns (uint) {
        return balances[msg.sender];
    }
}
