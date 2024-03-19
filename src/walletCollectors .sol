pragma solidity ^0.6.6;

contract Collectores {
    address public owner;
    mapping(address => bool) public collectors;

    constructor() public {
        owner = msg.sender;
        // Owner is also a collector by default
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
