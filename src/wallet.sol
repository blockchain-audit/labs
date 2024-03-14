
pragma solidity >=0.6.12 <0.9.0;

contract wallet {
    address payable private owner;
  
    constructor()  {
        owner = payable(msg.sender);
    }

     receive() external payable  {}

    function withdraw(uint wad) external {

        payable(msg.sender).transfer(wad);
    }


    function getBalance() public view returns (uint){

        return address(this).balance;
    }

}
