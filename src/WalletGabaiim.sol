// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract WalletGabaiim {
    address public owner;
    mapping (address => bool)public gabaiim ;
    uint public countGabaiim = 0;



    constructor() {
        owner =  msg.sender;
    }

    receive() external payable { }



    function withdraw(uint256 amount) public isOwnerOrGabai{
        require(payable(address(this)).balance >= amount,"Not Enough Money in wallet");
        payable(msg.sender).transfer(amount);
    }
   
    function addGabai(address newGabai) public {
        require(msg.sender == owner ,"not owner");
        require(!gabaiim[newGabai],"the gabai already exsist");
       if(countGabaiim < 3){
            countGabaiim++;
            gabaiim[msg.sender] = true;
       }
       else{
        revert("there are already 3 gabaiim");
       }
    }
        
    function changeGabai(address oldGabai,address newGabai)public{
        require(msg.sender==owner,"You do not have permission to do so");
        require(gabaiim[oldGabai],"the adress oldGabai not gabai");
        require(!gabaiim[newGabai], "the new gabai already gabai");
        gabaiim[oldGabai] = false;
        gabaiim[newGabai] = true;
    }

    function balance() public view returns(uint){
        return address(this).balance;
    }
     modifier isOwnerOrGabai (){
         require(msg.sender == owner || gabaiim[msg.sender],
         "sender is not owner or gabai" );
          _;
    }
    
}
