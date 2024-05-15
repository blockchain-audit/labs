    //SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.15;

import "@labs/tokens/MyToken.sol";
import "forge-std/console.sol";

contract Amm {
    MyToken tokenA;
    MyToken tokenB;
    uint256 wad = 1e18;
    uint256 public totalLiquidity = 0;
    mapping(address => uint256) public liquidity;
    uint256 public balanceA;
    uint256 public balanceB;

    constructor(address _tokenA, address _tokenB) {
        tokenA = MyToken(_tokenA);
        tokenB = MyToken(_tokenB);
    }

    function tradeAToB(uint256 amountA) public {
        require(totalLiquidity > 0, "the liquidity is empty");
        require(amountA != 0, "amount = 0");
        tokenA.transferFrom(msg.sender, address(this), amountA);
        balanceA += amountA;
        uint256 countB = calcCount(balanceA, balanceB, amountA, 1);
        tokenB.transfer(msg.sender, countB);
        balanceB -= countB;
        totalLiquidity = balanceA + balanceB;
    }

    function tradeBToA(uint256 amountB) public {
        require(totalLiquidity > 0, "the liquidity is empty");
        require(amountB != 0, "amount = 0");
        tokenB.transferFrom(msg.sender, address(this), amountB);
        balanceB += amountB;
        uint256 countA = calcCount(balanceA, balanceB, amountB, 2);
        tokenA.transfer(msg.sender, countA);
        balanceA -= countA;
        totalLiquidity = balanceA + balanceB;
    }

    function addLiquidity(uint256 amountA, uint256 amountB) public {
        if (totalLiquidity == 0) {
            liquidity[msg.sender] = (amountA + amountB) / 2;
        } else {
            // console.log(
            //     amountA * getValueOfAPer1Token() / wad + amountB * getValueOfBPer1Token() / wad,
            //     totalLiquidity,
            //     "]]]]]]]]]]}}"
            // );
            // console.log(getValueOfAPer1Token(), getValueOfBPer1Token(), "00000000000000");
            // console.log(amountA, amountB, "----------------");
            // console.log(amountA * getValueOfAPer1Token() / wad, "===================", amountB * getValueOfBPer1Token() / wad);
            require(balanceA * wad / balanceB == amountA * wad / amountB);
            // require(amountA * getValueOfAPer1Token() / wad == amountB * getValueOfBPer1Token() / wad, "not equals value");
            liquidity[msg.sender] = amountA * getValueOfAPer1Token() / wad;
        }
        tokenA.transferFrom(msg.sender, address(this), amountA);
        tokenB.transferFrom(msg.sender, address(this), amountB);
        balanceA += amountA;
        balanceB += amountB;
        totalLiquidity = balanceA + balanceB;
    }

    function removeAllLiquidity() public {
        console.log(totalLiquidity, balanceA, "--------------");
        uint256 countA = liquidity[msg.sender] *wad/ getValueOfAPer1Token();
        uint256 countB = liquidity[msg.sender] *wad/ getValueOfBPer1Token();
        tokenA.transfer(msg.sender, countA);
        balanceA -= countA;
        tokenB.transfer(msg.sender, countB);
        balanceB -= countB;
        totalLiquidity = balanceA + balanceB;
    }

    function calcCount(uint256 _balanceA, uint256 _balanceB, uint256 amount, uint256 kindOfToken)
        public
        pure
        returns (uint256)
    {
        require(amount > 0, "your sum is zero");
        if (kindOfToken == 1) {
            return (_balanceB * 1e18 / _balanceA) * amount / 1e18;
        }
        return (_balanceA * 1e18 / _balanceB) * amount / 1e18;
    }

    function calcCountB(uint256 amount) public view returns (uint256) {
        uint256 value = amount * getValueOfAPer1Token() / wad;
        return value * wad / getValueOfBPer1Token();
    }

    function calcCountA(uint256 amount) public view returns (uint256) {
        uint256 value = amount * getValueOfBPer1Token() / wad;
        return value * wad / getValueOfAPer1Token();
    }

    function getValueOfAPer1Token() public view returns (uint256) {
        return (totalLiquidity / 2) * wad / balanceA;
    }

    function getValueOfBPer1Token() public view returns (uint256) {
        return (totalLiquidity / 2) * wad / balanceB;
    }
}
