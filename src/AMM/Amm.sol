// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.15;

import "@labs/staking/MyToken.sol";

contract Amm {
    MyToken tokenA;
    MyToken tokenB;
    uint256 wad = 1e18;
    // uint256 public total = 0;
    mapping(address => uint256) public liquidity;
    uint256 public balanceA;
    uint256 public balanceB;

    constructor(address _tokenA, address _tokenB) {
        tokenA = MyToken(_tokenA);
        tokenB = MyToken(_tokenB);
    }

    // modifier isOwner(msg.sender) {

    // }
    function tradeAToB(uint256 amountA) public {
        require(amountA!=0,"amount = 0");
        tokenA.transferFrom(msg.sender,address(this),amount);
        balanceA+=amount;
        uint256 countB = calcCount(balanceA, balanceB, amountA, 1);
        tokenB.transfer(msg.sender,countB);
        balanceB -= countB;
    }

    function calcCount(uint256 _balanceA, uint256 _balanceB, uint256 amount, uint256 kindOfToken)
        public
        pure
        returns (uint256)
    {
        require( amount > 0 , "your sum is zero");
        if (kindOfToken == 1) {
            return (_balanceB * 1e18 / _balanceA) * amount / 1e18;
        }
        return (_balanceA * 1e18 / _balanceB) * amount / 1e18;
    }

}
