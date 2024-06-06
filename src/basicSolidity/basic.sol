// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

contract HelloWorId{
    string public greet = "Hellow wolrd!";
}

contract Counter{
    uint256 public count;

    function get() public view returns (uint256){
        return count;
    }

    function inc() public {
        count += 1;
    }

    function dec() public {
        count -= 1;
    }
}

contract Primitives{
    bool public boo = true;

    uint8 public u8 = 1;
    uint256 public u256 = 456;
    uint256 public u = 123;

    int public i8 = -1;
    int public i256 = 456;
    int public i = -123;

    int256 public minInt = type(int256).min;
    int256 public maxInt = type(int256).max;

    address public addr = 0xCA35b915458EF540aDe6068dFe2F44E8fa733c;

    0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;

    bytes1 a = 0xb5; // 10110101
    bytes1 b = 0x56; // 01010110

    bool public defaultBoo; //false
    uint256 public defaultUint; // 0 
    int256 public defaultInt; //0
    address public defaultAddr; // 0x0000000000000000000000000000000000000000
}

contract variabels{
    
}
