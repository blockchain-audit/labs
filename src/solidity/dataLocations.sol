pragma solidity ^0.8.24;

contract dataLocations {

    uint256 public arr;
    mapping (uint256 => address) public map;

    struct my{
        uint256 num;
    }

    mapping (uint256 => my) mymap;

    function f() public {
        l(arr, map, mymap[1]);

        my storage mine = mymap[1];
        my memory me = my(1);
    }

     function l(uint256[] storage _arr, mapping(uint256 => address) storage _map, my storage myStruct) internal {
        arr.append(myStruct.num);
    }

    function g(uint256[] memory _arr) public returns (uint256[] memory) {
        
    }

    function h(uint256[] calldata _arr) external {

    }



}