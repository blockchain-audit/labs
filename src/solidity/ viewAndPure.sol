pragma solidity ^0.8.24;

contract viewAndPure {
    // does not make changes in the state

    uint256 public x = 1;
    function addY(uint256 y) public view returns (uint256) {
        return x + y;
    }
    
    function add(uint256 a, uint256 b) public pure returns (uint256) {
        return a+b;
    }
}