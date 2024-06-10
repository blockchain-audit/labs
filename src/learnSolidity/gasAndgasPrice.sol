// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Gas {
    uint256 public i = 0;
    // using all of the gas you ssent for transaction will cause to fail.
    function forever() public {
        // the loop will run until we will not have enough gas then it will return fail.
        while (true) {
            i += 1;
        }
    }
}
