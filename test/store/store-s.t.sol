// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/store/store.sol";

contract SimpleStoreTest is Test {
    /// @dev Address of the SimpleStore contract.
    Store public s;

    /// @dev Setup the testing environment.
    function setUp() public {
        s = new Store();
        address my_add = address(s);
    }

    /// @dev Ensure that you can set and get the value.
    function testSetAndGetValue(uint256 value) public {
        s.setValue(value);
        assertEq(value, s.getValue());
    }

    function testSetInternal() public {
        s.setInternal(true);
        assertEq(true, s.getBool());
    }
}
