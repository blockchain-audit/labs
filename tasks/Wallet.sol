// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "forge-std/console.sol";

contract SmartWallet {
    address [] public owners;

    constructor() {
        owners.push(0xAb5801a7D398351b8bE11C439e05C5B3259aeC9B);
        owners.push(0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c);
        owners.push(0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db);
    }
    
    function getOwners() external view returns (address[] memory) {
    return owners;
}
    modifier isOwner (){
        console.log(owners[0]);
        bool isOwners = false;
        
        if(msg.sender == owners[0] || msg.sender == owners[1] || msg.sender == owners[2])isOwners = true;
        require(isOwners ,"is not owner");
    _;
    }    

    receive() external payable {}

    // receive() external payable {
    //     emit Received(msg.sender, msg.value);
    // }


    function withdraw(uint256 amount) public isOwner{
  
        payable(msg.sender).transfer(amount);

    }

    function AddOwner(address newOwner,address oldOwner) public isOwner{
  
            if(owners[0] == newOwner || owners[1] == newOwner  || owners[2] == newOwner){}  
            else{
                 if(owners[0] == oldOwner ) owners[0] = newOwner;
                 if(owners[1] == oldOwner ) owners[1] = newOwner;
                 if(owners[2] == oldOwner ) owners[2] = newOwner;
            }
    }    


    

    

    //Returns the current balance of the smart contract
     function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    
}
