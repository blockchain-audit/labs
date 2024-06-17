// SPDX-License-Identifier: private
pragma solidity ^0.8.20;

interface IERC20 {
    function symbol() external view returns (string memory);

    function totalSupply() external view returns (uint256);

    function balanceOf(address guy) external view returns (uint256);

    function transfer(address dst, uint256 wad) external returns (bool);

    function allowance(address own, address guy) external view returns (uint256);

    function approve(address guy, uint256 wad) external returns (bool);

    function transferFrom(address src, address dst, uint256 wad) external returns (bool);

    event Transfer(address indexed src, address indexed dst, uint256 wad);
    event Approval(address indexed own, address indexed guy, uint256 wad);
}
