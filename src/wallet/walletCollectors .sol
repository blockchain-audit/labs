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

// The contract named Collectores
contract Collectores {
    // A public variable that represents the owner of the contract
    address public owner;
    //Mapping that maps a collector's address to whether it belongs to one of three collectors or not
    mapping(address => bool) public collectors;
    // Constructor function that builds the contract
    constructor() public {
        owner = msg.sender;
        // Owner is also a collector by default
        // The contract owner is also a collector by default
        collectors[msg.sender] = true;
    }
    
    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only owner or collectors can call this function"
        );
        _;
    }

    function addCollector(address _collector) public onlyOwner {
        collectors[_collector] = true;
    }

    function removeCollector(address _collector) public onlyOwner {
        collectors[_collector] = false;
    }

    function deposit() public payable {
        // Anyone can deposit funds into the contract
    }

    function withdraw(uint256 _amount) public {
        require(
            collectors[msg.sender] || address(this).balance >= _amount,
            "Only owner or collectors can withdraw funds"
        );
        payable(msg.sender).transfer(_amount);
       // _;
    }
}
