pragma solidity >=0.6.12 <0.9.0;

///@dev set and change owner

contract Owner {
    address private owner;

    //what is event and what is indexed
    event OwnerSet(address indexed oldOwner, address indexed newOwner);

    //check if the call is owner
    modifier isOwner() {
        //check if sender is owner if not - not make the trenzaction
        require(msg.sender == owner, "Caller is not owner ");
        //what is?
        _;
    }

    constructor() {
        owner = msg.sender;
        //what is address(0)?
        emit OwnerSet(address(0), owner);
    }

    function changeOwner(address newOwner) public isOwner {
        emit OwnerSet(owner, newOwner);
        //posting the new owner
        owner = newOwner;
    }

    //return address of owner
    //what is external?
    function getOwner() external view returns (address) {
        return owner;
    }
}
