//     //SPDX-License-Identifier: GPL-3.0
// pragma solidity ^0.8.15;

// import "@labs/staking/MyToken.sol";

// contract Amm {
//     MyToken tokenA;
//     MyToken tokenB;
//     uint256 wad = 1e18;
//     uint256 public totalLiquidity = 0;
//     mapping(address => uint256) public liquidity;
//     uint256 public balanceA;
//     uint256 public balanceB;

//     constructor(address _tokenA, address _tokenB) {
//         tokenA = MyToken(_tokenA);
//         tokenB = MyToken(_tokenB);
//     }

//     // modifier isOwner(msg.sender) {

//     // }
//     function tradeAToB(uint256 amountA) public {
//         require(amountA != 0, "amount = 0");
//         tokenA.transferFrom(msg.sender, address(this), amount);
//         balanceA += amount;
//         uint256 countB = calcCount(balanceA, balanceB, amountA, 1);
//         tokenB.transfer(msg.sender, countB);
//         balanceB -= countB;
//         totalLiquidity = balanceA+balanceB;
//     }

//     function tradeBToA(uint256 amountB) public {
//         require(amountB != 0, "amount = 0");
//         tokenB.transferFrom(msg.sender, address(this), amountB);
//         balanceB += amount;
//         uint256 countA = calcCount(balanceA, balanceB, amountB, 2);
//         tokenA.transfer(msg.sender, countA);
//         balanceA -= countA;
//         totalLiquidity = balanceA+balanceB;
//     }

//     function addLiquidity(uint256 amountA, uint256 amountB) public {
//         require(amountA * getValueOfAPer1Token() == amountB * getValueOfBPer1Token());
//         tokenA.transferFrom(msg.sender, address(this), amountA);
//         tokenB.transferFrom(msg.sender, address(this), amountB);
//         balanceA += amountA;
//         balanceB += amountB;
//         liquidity[msg.sender] = amountA * getValueOfAPer1Token();
//         totalLiquidity += amountA + amountB;
//     }

//     function removeAllLiquidity() public {
//         countA = liquidity[msg.sender] / getValueOfAPer1Token();
//         countB = liquidity[msg.sender] / getValueOfBPer1Token();
//         tokenA.transfer(msg.sender, countA);
//         balanceA -= countA;
//         tokenB.transfer(msg.sender, countB);
//         balanceB -= countB;
//         totalLiquidity = balanceA + balanceB;
//     }

//     function calcCount(uint256 _balanceA, uint256 _balanceB, uint256 amount, uint256 kindOfToken)
//         public
//         pure
//         returns (uint256)
//     {
//         require(amount > 0, "your sum is zero");
//         if (kindOfToken == 1) {
//             return (_balanceB * 1e18 / _balanceA) * amount / 1e18;
//         }
//         return (_balanceA * 1e18 / _balanceB) * amount / 1e18;
//     }

//     function getValueOfAPer1Token() public returns (uint256) {
//         return totalLiquidity / 2 / balanceA;
//     }

//     function getValueOfBPer1Token() public returns (uint256) {
//         return totalLiquidity / 2 / balanceB;
//     }

//     //ba = 10
//     //bb = 5

//     //aa = 5
//     //ab = 2.5
// }
