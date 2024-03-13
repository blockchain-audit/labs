pragma solidity >=0.7.0 <0.9.0;

//the contract name is storage
contract storage{
//variable
    uint256 number;

    function store(uint256 num) public {
        number = num;
    }
//view- doesnt change the state 
    function retrieve() public  view returns (uint256){
        return number;
    }
//this contract store integer value and return the value
}
