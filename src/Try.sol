// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract SimpleBank {
    //private  =Permissions of parametr
    //uint= type integer
    //mapping=like dictionery inn c#
    //address=value in dictionry
    //uint=int (key)
    //balance=name of dictionery    mapping (address => uint) private balances;
    // Owner of the contract
    mapping (address=>uint)private  balances;
    //public =Permissions of parametr
    address public owner;
    // event =event in code like input output in angular but in solidity it conect with 2 factors  listeners
    event LogDepositMade(address accountAddress, uint amount);
    //this is run just one time and initialization parameters
    constructor ()  {
        owner = msg.sender;
    }
    // Deposit function
    function deposit() payable public returns (uint) {
        //payable kind of coin =eterum
        //require =if another languege
        require((balances[msg.sender] + msg.value) >= balances[msg.sender]);
        //change parameter
        balances[msg.sender] += msg.value;
        emit LogDepositMade(msg.sender, msg.value);
        return balances[msg.sender];
    }
    //this function get the amount you want get out from acounnt
    function withdraw(uint withdrawAmount) public returns (uint remainingBalance) {
    // withdrowawmount=amount
    //remainingBal=parameter that returen the amount after push withdrowawmount
    //this condtion if there are enough balannces[msg.sender] that can push withdrowawmount
    require(withdrawAmount <= balances[msg.sender]);
    //update
    balances[msg.sender] -= withdrawAmount;
    //Performs the transfer of the money
    payable(msg.sender).transfer(withdrawAmount);
    //msg.sender.transfer(withdrowawmount);
    return balances[msg.sender];
    }
    // Function to get the balance of the sender
    function getBalance() public view returns (uint) {
        return balances[msg.sender];
    }
}
