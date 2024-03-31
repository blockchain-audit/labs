// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;
import "forge-std/console.sol";

contract WalletGabaim {
    address payable public owner;
    //key=address value =1 if is owner or 0 not
    // mapping(address => uint256) public myHashTable;
        // mapping(uint256 => mapping(address => uint)) public myHashTable;
   struct UserInfo {
        bool isCollector; // true if the address is a collector, false otherwise
        uint withdrawalAmount; // amount that the collector can withdraw
    }

    mapping(address => UserInfo) public myHashTable;

    uint256 balance;
    constructor() {
        owner = payable(msg.sender);
        myHashTable[0x5B38Da6a701c568545dCfcB03FcB875f56beddC4].isCollector = true;
        myHashTable[0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2].isCollector = true;
        myHashTable[0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db].isCollector = true;
    }
    //like export in react
    receive() external payable {}
    function withDraw(uint256 amount) public {
        require(myHashTable[msg.sender].isCollector == true|| msg.sender==owner, "Only the owner can withdraw");
        //address(this)=זה הכתובת של הארנק של החוזה
        // require(amount <= address(this).balance, "Dont have enough money");
        if(msg.sender==owner){
            require(amount <= address(this).balance, "Dont have enough money");

        }
        else{
             require(amount <= myHashTable[msg.sender].withdrawalAmount , "Dont have enough money");

        }

        //מי שבא למשוך הוא אמור לקבל את הכסף
        payable(msg.sender).transfer(amount);
    }
    function changeOwners(address newOwner, address oldOwner,uint256 withdrawalAmount) public {
        require(msg.sender == owner, "Only the Owner allowed to do this");
        require(myHashTable[newOwner].isCollector != true, "you are owner");
        myHashTable[newOwner] .isCollector = true;
        myHashTable[newOwner] .withdrawalAmount = withdrawalAmount;
        myHashTable[oldOwner] .isCollector = false;
    }
    function getValue() public view returns (uint256) {
        return address(this).balance;
    }
    function getGabaim(address hashAddress)public view returns (bool){
        return (myHashTable[hashAddress].isCollector);
    }
 
}
