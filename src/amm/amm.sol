pragma solidity ^0.8.24;
// // import "/home/user/Documents/yehudis/labs/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
// import "../../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
// contract AMM{
// //    uint256 total = balanceA + balanceB;
// //    uint256 price() * balanceA ≈ balanceB; 
//     IERC20 public immutable tokenA;
//     IERC20 public immutable tokenB;

//     uint256 public balanceA;
//     uint256 public balanceB;

//     uint256 public total;

//     mapping(address => uint) public balanceOf;

//    constructor (address _tokenA , address _tokenB){
//     tokenA = IERC20(_tokenA);
//     tokenB = IERC20(_tokenB);
//    }
//    function initialize(){

//    }
// //    function price(IERC20 token) public returns(uint){
// //        return WAD * kFactors / token.balanceOf(msg.sender);}
//    function price(){

//    }
//    function tradeAToB(uint256 amountA) external returns (uint256 amountB){
//     require(amountA > 0 );
//     require(tokenA.balanceOf(msg.sender)>= amountA);
//     tokenA.transferFrom(msg.sender ,address(this),amountA);
//     uint256 amountFee = (amountA * 997) / 1000;
//     amountB = (balanceB * amountFee )/(balanceA + amountFee);
//     require(tokenB.balanceOf(address(this)) >= amountB);
//     tokenB.transfer(msg.sender,amountB);
//    }
//    function tradeBToA(uint256 amountB) external returns (uint256 amountA){
//     require(amountB > 0 );
//     require(tokenB.balanceOf(msg.sender)>= amountB);
//     tokenB.transferFrom(msg.sender ,address(this),amountB);
//     uint256 amountFee = (amountB * 997) / 1000;
//     amountA = (balanceA * amountFee )/(balanceB + amountFee);
//     require(tokenA.balanceOf(address(this))>=amountA);
//     tokenA.transfer(msg.sender,amountA);

//    }
//    function addLiquidity(){

//    }
//    function removeLiquidity(){

//    }
// }