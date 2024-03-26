// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/store/store.sol";

contract SimpleStoreTest is Test {
    // It works like a pointer to the
    // Store contract
    Store public s;

    // Everything I need to start my test
    function setUp() public {
        // deploy the Store contract in the
        // local blockchain node
        s = new Store();
    }

    /// @dev Ensure that you can set and get the value.
    function testSetAndGetValue(uint256 value) public {
        s.setValue(value);
        assertEq(value, s.getValue());
    }
}
