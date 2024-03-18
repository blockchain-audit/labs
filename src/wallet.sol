
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Wallet {
    address [] public owners;

    // Constructor sets the owner of the contract
    constructor() {
        owners[0] = msg.sender;
        owners[1] = msg.sender;
        owners[2] = msg.sender;
        // owners = msg.sender;
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

    function addOwner(address newOwner,address oldOwner) public isOwner{
            
            // require(owners[0] == newOwner && owners[1] == newOwner && owners[2] == newOwner, "Owner already exists");
            // owners.push(newOwner);

            if(owners[0] == newOwner || owners[1] == newOwner  || owners[2] == newOwner){}  
            else{
                 if(owners[0] == oldOwner ) owners[0] = newOwner;
                 if(owners[1] == oldOwner ) owners[1] = newOwner;
                 if(owners[2] == oldOwner ) owners[2] = newOwner;
            }
           

    }    
    //  event Output(string message, uint256 value);


    modifier isOwner (){

        bool isOwners = false;
        
        if(msg.sender == owners[0] || msg.sender == owners[1] || msg.sender == owners[2])isOwners = true;

        // if(msg.sender == owners[0])isOwners = true;
        // else if(msg.sender == owners[1])isOwners = true;
        // else if(msg.sender == owners[2])isOwners = true;

        // for(uint i = 0; i < owners.length;i++){
        //     if(msg.sender == owners[i]){
        //        isOwners = true;
        //        break;
        //     }
        // }
        require(isOwners ,"is not owner");
    _;
    }

    

     function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    
}
            // if(owners[0] == oldOwner || owners[0] == newOwner) owners[0].push(newOwner);
            // if(owners[1] == oldOwner || owners[1] == newOwner) owners[0].push(newOwner);
            // if(owners[2] == oldOwner || owners[2] == newOwner) owners[0].push(newOwner);
            // owners[0].push(newOwner);    
            
            // if(owners[0] != newOwner) require(owners[0] == oldOwner ,"");
