
pragma solidity ^0.8.20;
//use for documentaion in three slashes  descriptive data for UI elements/actions
 /// @title SimplBank
 /// @author Chana

 //'Contract' is similar to CLASS in other languages with OOP
contract SimpleBenk{

  // Declare state variables outside
  // dictionary that maps addresses to balances
  //mapping monny acording to   wallet address (same to dictionary)
    mapping (address => uint) private balances;
    //'private': It is possible to view only the elements in the blockbook
    address public owner;
    //public : Publishing operations to external listeners such as reading but not writing
    event LogDepositMade(address accountAddress, uint amount);
     
     //constractor - receive one or many variables
     // A only one constractor allowed
     constructor() public{
        //msg -details about the message
        //address of contract creator 
        //msg.sender - is contract caller 
        owner = msg.sender;
     }
     /// @notice Deposit ether into bank
     /// @return The balance of the user after the deposit is made
     function Deposit() public payable returns (uint){
        //Deposit - name of the function
        //the function is public
        //payable - function that can accept a website as input. 
        //When a contract with a paid function is called, 
        //the caller can send a site along with the function call.
        // The site is then stored in the contract balance 
        
        // 'require' to check user input
        //'assert' for internal invariants
        //Checks that the leak is correct
        require((balances[msg.sender] + msg.value) >= balances[msg.sender]);
        balances[msg.sender] += msg.value;
         
        // no "this." or "self." required with state variable
        //emit - Used to trigger an event
        //LogDepositMade /name of emit
        //(msg.sender, msg.value) - The parameters passed to the event
        // all values set to data type's initial value by default
        //  msg.sender - represents the address of the account that sent the transaction.
        //  msg.value -  represents the amount of site (in Wei) sent with the transaction.

        emit LogDepositMade(msg.sender, msg.value); 

        //msg.sender: a global variable in Solidity that provides information about the transaction and its sender.
        // represents the address (20 byte value) of the account that sent the transaction
        //  balances: a mapping that stores the balances of different addresses or users in the smart contract.
        //Returns the balance associated with the sender of the current transaction
        return balances[msg.sender];
     }
     /// @notice Withdraw ether from bank
     ///@return reminigBal

     //uint - An unsigned integer
     //public - can be called an action outside the contract
     //(private - They can only be accessed from within the contract in which it is defined
     //Contracts and external entities cannot read or change the value of the variable or call the function directly)
     //require -use to verify conditions, if the value is false, unction execution will return
     //
     ///The function do:
     //A withdraw function that allows the user to withdraw a specified amount of funds from his balance in the smart contract.
     // The function enforces a check to ensure that the requested withdrawal amount does not exceed the available balance in the user's account.
     // If the condition is not met, the function will return,
     // preventing the withdrawal from taking place and maintaining the integrity of the contract state
     function withdraw(uint withdrawAmount) public returns (uint remainingBal)
     {
      require(withdrawAmount <= balances[msg.sender]);
      
     // Every .transfer/.send from this contract can call an external function
     // Aim to commit state before calling external functions, including .transfer/.send
     // Deduction of credit immediately before sending
     //The owner of the wallet to ask for a bigger one

      //Deduct from the account - from the wallet the amount withdrawn
      balances[msg.sender] -= withdrawAmount;

        //This automatically causes a failure, which means the updated balance has been returned

        //In case of fail // This automatically causes a failure, which means the updated balance has been returned
        //transfar the monny
         msg.sender.transfer(withdrawAmount);
        //return balance in  the vallet after the transfer
        return balances[msg.sender];
      }
      
      // @notice Get balance
      // allows function to run locally/off blockchain
      // 'view' (ex: constant) prevents function from editing state variables;
      ///@return - the msg.sender balance from the balance mapping after processing the withdrawal
      function balance() view public returns (uint){
        return balances[msg.sender];
      }
     }
   
// ** END **


