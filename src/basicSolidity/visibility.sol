// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

contract Base {
    function privateFunc() private pure returns (string memory) {
        return "private function callde";
    }

    function testPrivate() public pure returns(string memory) {
        return privateFunc();
    }

    function internalFunc() internal pure returns(string memory) {
        return "internal function called";
    }
    
    function testInternalFunc() public pure virtual returns (string memory) {
        return internalFunc();
    }

    function publicFunc() public pure returns (string memory) {
        return "public function called";
    }

    function externalFunc() external pure returns (string memory) {
        return "external function called";
    }

    string private privateVar = "my private variable";
    string internal internalVar = "my internal variable";
    string public publicVar = "my public variable";
}

contract Child is Base {
    function testInternalFunc() public pure override returns (string memory) {
        return internalFunc();
    }
}
