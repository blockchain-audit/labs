pragma solidity ^0.8.24;

import "./ISwapRouter.sol";

interface IUniswapRouter is ISwapRouter {
    function refundETH() external payable;
}
