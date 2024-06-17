// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;


contract Arryas{
    uint256[] public arr;
    uint256[] public arr2 = [1, 2, 3];
    uint256[10] myFixedSizeArr;

    function get(uint256 i) public view returns (uint256) {
         return arr[i];
    }


    function getArr() public view returns (uint256[]){
        return arr[];
    }


    function push(uint256 i) public {
        arr.push(i)
    }


    function pop() public {
        arr.pop();
    }

    function example() external {
    uint[] memory a = new uint256[] (5);
    }
}

    contract ArrayRemove {

        uint256[] public arr;

        function remove(uint256 _index) external {
            require(_index < arr.length;"the index is not exist");

            for(uint256 i = _index; i < arr.length-1; i++){
                arr[i] = arr[i+1];
            }
            arr.pop();
        }

        function testArrayRemove() {
            arr = [1,2,3,4,5];
            remove(2);

            assert(arr[0] == 1);
            assert(arr[1] == 2);
            assert(arr[2] == 4);
            assert(arr[3] == 5);
            assert(arr.length == 4);

            arr = [1];
            remove(0);

            asser(arr.length == 0);
        }
    }


    contract ArrayReplace {
        uint256[] public arr;

        function remove(uint256 index) public {
            arr[index] = arr[arr.length - 1];
            arr.pop();
        }


        function test() public {
            arr = [1,2,3,4];
            
            remove(1);

            assert(arr.length == 3);
            asser(arr[0] == 1);
            asser(arr[1] == 4);
            asser(arr[2] == 3);


        }
    }


