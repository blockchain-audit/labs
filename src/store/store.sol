// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.17;

contract Store {
    uint256 storedValue;

    uint public pubInt = 0;         // Automatically has a public getter func of same name.
                                    // Only public state vars can have NatSpec comments (since 0.7.0)
    bool internal _intBool = false; // Can only be used from this or inheriting contracts.

    uint internal _mutex = 1;   // See reentrancyGuard modifier.
    // Function to set the value
    function setValue(uint256 newValue) public {
        storedValue = newValue;
    }

    // Function to get the value
    function getValue() public view returns (uint256) {
        return storedValue;
    }

    function getBool() public view returns (bool)  {
        return _intBool;
    }


    function setInternal(bool v) public {
        _intBool = v;
    }
}
