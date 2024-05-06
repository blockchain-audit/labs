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
    //מספר המסמל את גורם מכפלת הK 
    //x * y = k
    uint kFactors;
    //אחוז הנזילות שכתובת ארנק סיפקה
    mapping(address=>uint) public liquidityProviders;
    uint constant WAD= 10**18;

    constructor(IERC20 tA, IERC20 tB, uint256 aA, uint256 aB){
        owner = msg.sender;
        tokenA = IERC20(tA);
        tokenB = IERC20(tB);
        initialize(aA, aB);
    }

    function initialize(uint256 initializeA, uint256 initializeB ) private{
        require(initializeA > 0 && initializeB > 0 && initializeA == initializeB, "InitialA and initialB must be greater than zero.");
        require(isInitialized == false, "");
        amountA = initializeA;
        amountB = initializeB;
        kFactors = initializeA;
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

     //הפונקציה מקבלת ערך של נזילות שמעוניינים להכניס לברכה
     function addLiquidity(uint value) public payable{
        require(value > 0, "The sum of the coins must be bigger than zero");
        uint amountTA = value / price(tokenA);
        uint amountTB = value / price(tokenA);
        require(tokenA.balanceOf(msg.sender) >= amountTA && tokenB.balanceOf(msg.sender) >= amountTB, "You don't have enough coins");
        tokenA.transferFrom(msg.sender, address(this), amountTA);
        tokenB.transferFrom(msg.sender, address(this), amountTB);
        liquidityProviders[msg.sender] = value;
        amountA += amountTA;
        amountB += amountTB;
        kFactors += value;
     }

     function removeLiquidity(uint value) public{
        require(value > 0, "The sum of the coins must be bigger than zero");
        require(liquidityProviders[msg.sender] >= value, "You don't have enough liquidity to withdraw");
        uint amountTA = value / price(tokenA);
        uint amountTB = value / price(tokenA);
        //uint percent = WAD * liquidityProviders[msg.sender] / KFactors**2;
        tokenA.transfer(msg.sender, amountTA);
        tokenB.transfer(msg.sender, amountTB);
        amountA -= amountTA;
        amountB -= amountTB;
        kFactors -= value;
     }

     //ערך למטבע
     //יש הכפלה בWAD
     function price(IERC20 token) public view returns(uint){
       return WAD * kFactors / token.balanceOf(address(this)); 
    } 
}