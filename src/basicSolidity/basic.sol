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

    address public addr = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;

    bytes1 a = 0xb5; // 10110101
    bytes1 b = 0x56; // 01010110

    bool public defaultBoo; //false
    uint256 public defaultUint; // 0 
    int256 public defaultInt; //0
    address public defaultAddr; // 0x0000000000000000000000000000000000000000
}

contract Variables{
    string public text = "Hello";
    uint public num = 123;

    function doSomething() public{
        uint256 i = 456;

        uint256 timestamp = block.timestamp;
        address sender = msg.sender;
    }
}

contract Constants{
    address public constant MY_ADDRESS = 0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;

    uint public constant MY_UINT = 123;
}

contract Immutable{
    address public immutable MY_ADDRESS;
    uint public immutable MY_UINT;

    constructor(uint _myUint){
        MY_ADDRESS = msg.sender;
        MY_UINT = _myUint;
    }
}

contract SimpleStorage{
    uint public num;

    function set(uint _num) public {
        num = _num;
    }

    function get() public view returns(uint){
        return num;
    }
}

contract EtherUnits{
    uint public oneWei = 1 wei;

    bool isOneWei = (oneWei == 1);

    uint public oneGwei = 1 gwei;

    bool public isOneGwei = (oneGwei == 1e9);

    uint public oneEther = 1 ether;

    bool public isOneEther = (oneEther == 1e18);
}

contract Gas{
    uint public i = 0;

    function forever() public {
        while(true){
            i += 1;
        }
    }
}

contract IfElse{
    function poo(uint256 x) public pure returns(uint56){
        if(x < 10){
            return 0;
        }
        else if(x < 20){
            return 1;
        }
        else{
            return 2;
        }
    }

    function ternary(uint _x) public pure returns(uint256){
        return _x < 10 ? 1: 2;
    }
}

contract Loop{
    function loop() public {
        for(uint i = 0; i < 10; i++){
            if(i == 3){
                continue;
            }
            if(i == 5){
                break;
            }
        }

        uint j =0;
        while(j > 10){
            j++;
        }
    }
}

contract Mapping{
    mapping(address => uint) public myMap;
    function get(address _addr) public view returns(uint){
        return myMap[_addr];
    }

    function set(address _addr, uint i) public{
        myMap[_addr] = i;
    }

    function remove(address _addr) public{
        delete myMap[_addr];
    }
}

contract NestedMapping{
    mapping (address => mapping(uint => bool)) public nested;

    function get(address _addr, uint i) public view returns(uint){
        return nested[_addr][i];
    }

    function set(address _addr, uint i, bool _boo) public{
        myMap[_addr][i] = _boo;
    }

    function remove(address _addr, uint i) public{
        delete myMap[_addr][i];
    }
}

contract Array{
    uint[] public arr;
    uint[] public arr2 = [1 ,2 ,3];
    uint[10] public myFixedSizeArr;

    function get(uint i) public view returns(uint){
        return arr[i];
    }
}

