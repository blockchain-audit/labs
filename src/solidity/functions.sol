pragma solidity ^0.8.24;

contract functions {
    // a function can return a few values 
    // the values couled be called in names
    // if the return value is assiged with a name - we can take of the return statment

    function manyValues() public pure returns (uint256, bool, uint256){
        return (123,true, 67);
    }

    function namedValues () public pure returns (uint256 a, bool b, uint256 c) {
        return (123,true, 67);
    }

    function assignedValues () public pure returns (uint256 a, bool b, uint256 c) {
        a = 123;
        b=true;
        c=98;
    }

    function destruct () public pure returns (uint256 a, bool b, uint256 c, uint256 d, uint256 e) {
        (uint256 a, bool b, uint256 c) = manyValues();
        (uint256 d, , uint256 e) = manyValues();
    }

    // you cannot use a map for an input or output to a function
    // you ca use an arrey

    function inputArr(uint256[] arr) public {

    }
    function outputArr () public returns (uint256[]){
    uint256[] public arr;
    return arr;
    }
    
}