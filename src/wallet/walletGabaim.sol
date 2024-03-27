// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;
import "forge-std/console.sol";

contract WalletGabaim {
    address payable public owner;
    //key=address value =1 if is owner or 0 not
    mapping(address => uint256) public myHashTable;
    uint256 balance;
    constructor() {
        owner = payable(msg.sender);
        myHashTable[0x5B38Da6a701c568545dCfcB03FcB875f56beddC4] = 1;
        myHashTable[0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2] = 1;
        myHashTable[0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db] = 1;
    }
    //like export in react
    receive() external payable {}
    function withDraw(uint amount) public {
        require(myHashTable[msg.sender] == 1, "Only the owner can withdraw");
        //address(this)=זה הכתובת של הארנק של החוזה
        require(amount <= address(this).balance, "no money");
        console.log(owner);
        console.log(address(this).balance);
        console.log("jj");
        console.log(msg.sender);
        //מי שבא למשוך הוא אמור לקבל את הכסף
        payable(msg.sender).transfer(amount);
        console.log(address(this).balance);
    }

    function changeOwners(address newOwner, address oldOwner) public {
        require(msg.sender == owner, "you are the not owner");
        require(myHashTable[newOwner] != 1, "you are owner");
        myHashTable[newOwner] = 1;
        myHashTable[oldOwner] = 0;
    }
    function getValue() public view returns (uint256) {
        return address(this).balance;
    }
}
