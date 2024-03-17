// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract wallet {
    address[] public owners; 
    // mapping (address => uint256) public balances;

    constructor() {
        owners.push(msg.sender);
    }

     receive() external payable { }

    // function receiveit() external payable {
    //     balances[msg.sender] += msg.value;
    // }
    function withdraw(uint256 amount) public {
        payable(msg.sender).transfer(amount);
    }
   
    function addOwner(address newOwner) public isOwner{
            owners.push(newOwner);    
        }
        
    function balance() public view returns(uint){
        return address(this).balance;
    }
     modifier isOwner (){
        bool isAdrsOwner = false;
        for(uint i = 0; i < owners.length;i++){
            if(msg.sender == owners[i]){
               isAdrsOwner = true;
               break;
            }
        }
        require(isAdrsOwner ,"is not owner");
    _;
    }
}
