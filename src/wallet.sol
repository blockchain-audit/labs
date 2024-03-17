
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Wallet {
    address [] public owners;

    // Constructor sets the owner of the contract
    constructor() {
        owners = msg.sender;
    }

    //1

    // Event emitted when ETH is received
    event Received(address indexed sender, uint256 amount);

    // Function to receive ETH
    receive() external payable {
        // Emit an event indicating the amount of ETH received and who sent it
        emit Received(msg.sender, msg.value);
    }

    //2
    function withdraw(uint256 amount)public{
        // require(msg.sender == owner,"WALLET-not-owner");
        // require(address(this).balance >= amount);
        payable(msg.sender).transfer(amount);

    }

    function addOwner(address newOwner) public isOwner{
            owners.push(newOwner);    
    }    
    //  event Output(string message, uint256 value);


     
    modifier isOwner (){
        bool isOwners = false;
        for(uint i = 0; i < owners.length;i++){
            if(msg.sender == owners[i]){
               isOwners = true;
               break;
            }
        }
        require(isOwners ,"is not owner");
    _;
    }

    

     function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    
}
