// SPDX-License-Identifier: MIT

/*
The Task:
only 3 gabaim
compare the gas cost with loop and without loop, avoid loops
the source code must be in the src/wallet folder
add the other .sol files into a folder, in a way that the src has only its folder
install the audit plugin here or another solidty vscode extension in order to see solidity code with colors
when you finish, update the column T2-SOL in our sheet file, with 1 when you finished
give a thumb here also
*/
// Setting the Solidity version in which the contract can run

// Setting the Solidity version in which the contract can run
pragma solidity ^0.8.20;

// @Auther: Chana Cohen
// @title Collectors

// The contract named Collectors
contract Collectors {
    // A public variable that represents the owner of the contract
    address public owner;
    //Mapping that maps a collector's address to whether it belongs to one of three collectors or not
    mapping(address => bool) public collectors;
    //The limit of number of collector can to be in this contract
    uint public limitCollectors;
    //Num of the collectors and owner
    uint numAuthorized;
    // Constructor function that builds the contract
    constructor() {
        owner = msg.sender;
        // The contract owner is also a collector by default.
        collectors[msg.sender] = true;
        //The mapping to 4: the owner and 3 collectors
        limitCollectors = 4; 
        // At first have only owner and he adding collectors
        numAuthorized = 1;
    }
    
    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only owner or collectors can call this function"
        );
        _;
    }

    /// @dev if owaner want to change tne number of the collectors.
    /// @param newLimit is the num of the collector thet can to be
    function changeLimit(uint newLimit) public onlyOwner{
    limitCollectors = newLimit;
    }
    
    /// @dev can receive monny to may wallet
    //This is build-in function
    receive() external payable{}

    /// @dev if the owner want to add collector.
    function addCollector(address newCollector) public onlyOwner {
        require(numAuthorized < limitCollectors, "There are maxsimum possible collectors.");
        require(collectors[newCollector] != true, "The collector is exsist.");
        collectors[newCollector] = true;
        numAuthorized++;
    }

    /// @dev the owner cat delete collector.
    function removeCollector(address _collector) public onlyOwner {
        require(_collector != owner && collectors[_collector] == true, "Can not remove the owner of the contract.");
        delete collectors[_collector];
        numAuthorized--;
    }
    /// @dev change collector
    //delete one collector and add a new collector
    function changeCollector(address collectorToChange, address newCollector) public onlyOwner
    {
        require(collectors[newCollector] != true, "The collector is exsist.");
        require(collectorToChange != owner ,"Cna not remove the owner of the contract.");
        delete collectors[collectorToChange];
        collectors[newCollector] = true;
    }

    /*
    /// @dev anyone can deposit monny to the contract.
    function deposit() public payable {
        // Anyone can deposit funds into the contract.
    }
    */
    
    /// @dev to withdraw monny from the contract the owner and collectors that they are true can to do.
    /// @param _amount is the sum that want to withdraw
    function withdraw(uint256 _amount) public {
        require(collectors[msg.sender],"Only owner or collectors can withdraw funds");
        require(address(this).balance >= _amount ,"It is not possible to withdraw funds beyond the balance");
        payable(msg.sender).transfer(_amount);
        // The balance is update automatically.
    }

    /// @dev shows the balance in the contract
    function getBalance() public view returns(uint){
    return address(this).balance;
    }
}