// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/console.sol";
import "../../MyToken.sol";

contract Tender {
   address  payable public owner;
   mapping(address => uint256) users;
   mapping(uint256 => address) counter;
   int256 wad = 10 ** 18;
   MyToken public immutable myCoinNFT;
   MyToken public immutable myCoineE;
   address public maxValue;
   uint256 public start = 0;
   uint256 public duration = 7 days;
   uint256 public count;
   bool public finish = false;    constructor(address _myCoinNFT,address _myCoineE) {
       myCoinNFT = MyToken(_myCoinNFT);
       myCoineE = MyToken(_myCoineE);
       owner = payable(msg.sender);
       users[owner] = 100;
       maxValue = owner;
   }    modifier openTender() {
       require(block.timestamp > duration, "time is finish");
       _;
   }    modifier isOwner() {
       require(msg.sender == owner, "you dont owner");
       _;
   }    function addOffer(uint256 amount) external {
       if (block.timestamp > duration) {
           require(amount > 0, "amount is zero");
           require(amount > users[maxValue], "your offer is less from max offer");
           maxValue = msg.sender;
           counter[count] = msg.sender;
          myCoineE.transferFrom(msg.sender, address(this),amount);
           users[msg.sender] = amount;
           count++;
       } else if (!finish) {
           endTender();
       }
   }    function removeOffer(address user) external isOwner openTender {
       require(users[user] < users[maxValue], "you cannot cancel offer becuse your offer is higher");
       users[user] = 0;
   }    function endTender() public {
       myCoinNFT.transferFrom(address(this),address(maxValue), 1);
       while (count > 0) {
           address currentAddress = counter[count - 1];
           uint256 val = myCoinNFT.balanceOf(address(currentAddress));
           myCoineE.transferFrom(address(this), msg.sender,val);
           count--;
       }
       finish = true;
   }
}
