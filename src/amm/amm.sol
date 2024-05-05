pragma solidity ^0.8.24;
// import "/home/user/Documents/yehudis/labs/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "../../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
contract AMM{
//    uint256 total = balanceA + balanceB;
//    uint256 price() * balanceA ≈ balanceB; 
    IERC20 public immutable tokenA;
    IERC20 public immutable tokenB;

    uint256 public balanceA;
    uint256 public balanceB;

    uint256 public total;

    mapping(address => uint) public balanceOf;

   constructor (address _tokenA , address _tokenB){
    tokenA = IERC20(_tokenA);
    tokenB = IERC20(_tokenB);
   }
   function initialize(){

   }
   function price(){

   }
   function tradeAToB(uint256 amountA){
    require(amountA > 0 );



   }
   function tradeBToA(uint256 amountB){

   }
   function addLiquidity(){

   }
   function removeLiquidity(){

   }
}