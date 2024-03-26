

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SmartWallet {
    address [] public owners;

    constructor() {
        owners[0] = msg.sender;
        owners[1] = msg.sender;
        owners[2] = msg.sender;
    }

    

    event Received(address indexed sender, uint256 amount);

    receive() external payable {
        emit Received(msg.sender, msg.value);
    }

    
    function withdraw(uint256 amount)public{
  
        payable(msg.sender).transfer(amount);

    }

    function addOwner(address newOwner,address oldOwner) public isOwner{
  
            if(owners[0] == newOwner || owners[1] == newOwner  || owners[2] == newOwner){}  
            else{
                 if(owners[0] == oldOwner ) owners[0] = newOwner;
                 if(owners[1] == oldOwner ) owners[1] = newOwner;
                 if(owners[2] == oldOwner ) owners[2] = newOwner;
            }
    }    


    modifier isOwner (){

        bool isOwners = false;
        
        if(msg.sender == owners[0] || msg.sender == owners[1] || msg.sender == owners[2])isOwners = true;
        require(isOwners ,"is not owner");
    _;
    }

    

     function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    
}
