// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;
contract wallet {
    address payable public owner;
    uint256 balance ;
    constructor(){
        owner=payable( msg.sender);
    }
    //like export in react
    receive() external payable { }
   
   function  withDraw(uint amount)public {
    require(msg.sender == owner,"Only the owner can withdraw");
    //address(this)=זה הכתובת של הארנק של החוזה 
    require(amount<=address(this).balance,"not enough eth in wallet");
     payable(owner).transfer(amount);  
  }
  
function getValue()external  view returns (uint){
    return address(this).balance;
}
}
