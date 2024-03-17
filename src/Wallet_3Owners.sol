// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;
contract wallet {
    address payable public owner;
    address[] public  owners;
    uint256 balance ;
    uint256 count=1;
    constructor(){
        owner=payable( msg.sender);
    }
    //like export in react
    receive() external payable { }
    modifier onlyOwner() {
        bool flag=false;
        for (uint i=0; i<owners.length; i++) 
        {
        require(owners[i]==msg.sender);
        flag=true;
        }
        require(flag, "you are not owner");
        _;
        

    } 
       
   function  withDraw(uint amount)public onlyOwner{
    require(msg.sender == owner,"Only the owner can withdraw");
    //address(this)=זה הכתובת של הארנק של החוזה 
    require(amount<=address(this).balance,"not enough eth in wallet");
     payable(owner).transfer(amount);  
  }
   
function addOwners(address newOwner)public {
    require(msg.sender == owner, "Only the owner can call this function");
    //require(msg.sender == owner, "Only the owner can call this function");
    require(count < 3 && count !=1, "There are enough owner");
    owners.push(newOwner);
    count++;

}

function getValue()external  view returns (uint){
    return address(this).balance;
}
}
