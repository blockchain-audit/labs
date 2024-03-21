// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;
contract wallet {
    address payable public owner;
    //key=address value =1 if is owner or 0 not 
    mapping(address => uint256) public myHashTable;
    uint256 balance ;
    constructor(){
        owner=payable( msg.sender);
        myHashTable[0x5B38Da6a701c568545dCfcB03FcB875f56beddC4]=1;
        myHashTable[0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2]=1;
        myHashTable[0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db]=1;
    }
    //like export in react
    receive() external payable { }
    function  withDraw(uint amount,address addressOwner)public {
    require(myHashTable[addressOwner]==1,"Only the owner can withdraw");
    //address(this)=זה הכתובת של הארנק של החוזה 
    require(amount<=address(this).balance,"not enough eth in wallet");
     payable(owner).transfer(amount);  
   }
   
    function changeOwners(address newOwner,address oldOwner)public {
    require(myHashTable[newOwner]!=1,"you are the owner");
    myHashTable[newOwner]=1;
    myHashTable[oldOwner]=0;
    }
    function getValue(address key) public view returns (uint256) {
        return myHashTable[key];
    }
}
