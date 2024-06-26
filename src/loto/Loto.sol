// SPDX-License-Identifier: MIT
pragma solidity >=0.5.11;

import "forge-std/console.sol";

contract Loto {
    uint256 randNo = 1;

    function rondomNumber() public {
        randNo = uint256(keccak256(abi.encodePacked(msg.sender, block.timestamp, randNo))) % 10 ** 6;
    }

    function getNumber() public view returns (uint256) {
        return randNo;
    }

    function run() public {
        rondomNumber();
        console.log(getNumber());
        console.log(block.prevrandao);
    }
}
