// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;


contract DataLocation {
    uint256[] public arr;
    mapping(address -> uint256) map;

    struct MyStruct {
        uint256 foo;
    }

    mapping (address -> MyStruct) myStructs;

    function f()public {
        _f(arr, map, myStruct[1]);
        
        //ניגש למערך מסוג המחלקה
        MyStruct storage ms = myStructs[1];
        //יוצר מצביע למחלקה
        MyStruct storage mss = myStructs(0);
    }

    function _f(
        uint256[] storage arr,
    mapping(address -> uint256) storage map,
    MyStruct storage _myStruct
    ) internal {
        require(arr.length != null, "the arraay is null");
        _myStruct.foo = arr[0];
        map[msg.sender] ++;
    }


    function g(uint256[] memory _arr) public returns (uint256[] memory) {
    }


    function h(uint256[] calldata _arr) external {
    }

}