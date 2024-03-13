
pragma solidity >=0.6.12 <0.9.0;


contract Storage{
    uint256 number;

//posting value in number 
    function store (uint256 num) public {
        number = num;
    }

    //return number
    //view - can not change the state value
    function retrieve() public view returns (uint256){
        return number;
    }
}
