// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract Seaport {
    function _name() internal pure returns (string memory) {
        // Return the name of the contract.
        assembly {
            mstore(0x20, 0x20)
            mstore(0x47, 0x07536561706f7274)
            return(0x20, 0x60)
        }
    }
}
