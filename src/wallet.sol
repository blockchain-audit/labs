
// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract wallet {
    address payable public owner; 
    mapping (address => uint256) public balances;

    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable { }

    function receiveit() external payable {
        balances[msg.sender] += msg.value;
    }
    function withdraw(uint256 amount) public {
        require(msg.sender == owner);
        payable(owner).transfer(amount);
    }
    function balance() public view returns(uint){
        return address(this).balance;
    }
}
