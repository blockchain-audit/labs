// SPDX-License-Identifier: MIT
pragma solidity >=0.5.11;

import "forge-std/console.sol";

enum eat {
    cookies,
    cake,
    chocolate
}

struct todo {
    string text;
    bool isDo;
}

contract Enum {
    todo[] public todos;
    todo public s = todo("sdsd", false);
    mapping(uint256 => uint256) public map;

    constructor() {}

    function f() public {
        // todo storage s = todo("sdsd",false);
    }

    function run() public {
        console.log(s.text);
        // eat eats = eat.chocolate;
        console.log(uint256(eat.cake));
        todo memory t1 = todo({text: "aaaaaaaaaa", isDo: false});
        todo memory t2 = todo({text: "bbbbbbbbbb", isDo: false});

        todos.push(t1);
        todos.push(t2);

        console.log(todos[1].text);
        (uint256 x, bool y) = fun();
        console.log(x, "fun", y);
        (, y) = fun();
        console.log("fun", y);

        (x, y) = fun1();
        console.log(x, "fun1", y);

        fun2({y: true, x: 654});
        fun2({y: y, x: x});

        // fun3();
        viewFun();
        funError(50);
    }

    function fun() public pure returns (uint256, bool) {
        return (2, false);
    }

    function viewFun() public view {
        console.log(todos[0].text);
        //error
        // todos[0].text = "76543";
    }

    function fun1() public pure returns (uint256 x, bool y) {
        x = 5;
        y = true;
    }

    function fun2(uint256 x, bool y) public view {
        console.log(x, y);
    }

    // function fun3() public returns(mapping(uint=> uint) memory map) {
    //     mapping(uint256 => uint256) storage map;
    //     console.log(map[0]);
    // }

    error big20(uint256 x);

    function funError(uint256 x) public pure {
        if (x == 0) {
            revert("zero");
        }
        require(x > 10, "small 10");

        assert(x > 10);

        revert big20(x);
    }
}
