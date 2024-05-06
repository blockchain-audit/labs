pragma solidity >=0.7.0 <0.9.0;

contract Owner {
    //a private state to store the ethereum address 
    address private owner;
//event that emit when the owner of the contract change
//the parameters are the oldest and the new adresses
    event OwnerSet(address indexed oldOwner, address indexed newOwner);
    //check if you the owner if not return error message
    modifier isOwner(){
        require(msg.sender == owner,"Caller is not owner");
        _;
    }
     constructor() {
        owner = msg.sender;
        //the old owner
        emit OwnerSet(address(0),owner);
     }
     //the current owner change the owner of the contract and update the address
      function changeOwner(address newOwner) public isOwner {
        emit OwnerSet(owner, newOwner);
        owner = newOwner;
    }
    //to get the owner's address
    //get function 
    function getOwner() external view returns (address) {
        return owner;
    }
    
}
