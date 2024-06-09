// SPDX-License-Identifier: MIT
pragma solidity >=0.5.11;

contract Hello {
   function main()public{
    assembly{
        mstore(0x20,0x20)
        mstore(0x47, 0x07536561706f7274)
        return(0x20,0x60)
    }
   }
}
