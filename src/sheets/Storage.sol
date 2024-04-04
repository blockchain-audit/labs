// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Storage {
    uint256 number;

    //setter
    function store(uint256 num) public {
        number = num;
    }

    //getter
    function retrieve() public view returns (uint256) {
        return number;
    }
}
