// SPDX-License-Identifier: MIT
pragma solidity >=0.5.11;


interface IWETHGateway{

    function depositETH(
        address lendingPool,
        address onBehalfOf,
        uint16 referralCode
    )external payable;

    function withdrawETH(
        address lendingPool,
        uint amount,
        address  onBehalfOf
    ) external;
}