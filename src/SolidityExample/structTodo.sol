// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract StructTodo {
    struct Todo{
       string text;
       bool completed;
    }

    Todo[] public todos;

    function create(string calldata _text) public {
        //first way
        todos.push(_text, false);

        //second way
        todos.push(Todo(text: _text, completed: false));

        //thered way
        Todo memory todo;
        todo.text = _text;
        todos.push(todo);
       
    }


    functio get(uint256 _index)public view returns (string memory text, bool completed){
        Todo storage todo = todos[_index];
        return (todo.text' todo.completed);
    }


    function updateText(uint256 _index, string calldata _text) public{
        Todo storage todo = todos[_index];
        todo.text = _text;
    }

    function updateCompleted(uint256 _index) public {
        Todo storage todt = todos[_index];
        todo.completed = !todo.completed;
    }

}