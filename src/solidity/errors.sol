pragma solidity ^0.8.24;

contract errors {
    function requireTest(uint256 i) public pure{
        require (i > 10 , " i must be grater then 10");
    }

    function revertTest(uint256 i) public pure {
        if ( i < = 10) 
        revert(" i must be grater then 10");
    }

    uint256 public num;

    function assertTest() public view {
        assert( num == 0);

    }

    error insufficientBalance(uint256 balance, uint256 withraw);

    function errorTest(uint256 amount) public view {
        uint256 bal = address(this).balance;
        if (bal < amount){
            revert insufficientBalance({
                    balance : bal,
                    withraw : amount
                })
        }
    }
}