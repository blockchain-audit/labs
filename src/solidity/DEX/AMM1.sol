// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;
import "@openzeppelin/ERC20/IERC20.sol";
contract AMM1{
    address public owner;
    IERC20 public immutable tokenA;
    IERC20 public immutable tokenB;
    uint256 public amountA;
    uint256 public amountB;
    bool isInitialized;

    constractor public(IERC20 tA, IERC20 tB, uint256 aA, uint256 aB){
        owner = msg.sender;
        tokenA = IERC20(tA);
        tokenB = IERC20(tB);
        initialize(aA, aB);
        
    }

    function initialize(uint256 initializeA, uint256 initializeB ) private{
        require(initializeA > 0 && initializeB > 0, "InitialA and initialB must be greater than zero.");
        require(isInitialized == false, "");
        amountA = initializeA;
        amountB = initializeB;
        isInitialized = true;
    } 

    modifier onlyOwner() {
        require(msg.sender == owner, "not authorized");
        _;
    }
   
     function tradeAToB() public payable{

     }

     function tradeBToA() public payable{

     }

     function addLiquidity public pay

}