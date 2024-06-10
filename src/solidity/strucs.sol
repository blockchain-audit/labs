pragma solidity ^0.8.24;

contract todos{
    struct Todo{
        string text;
        bool completed;
    }
    Todo[] public todo;

    function create(string calldata _text) public {
        todo.push(Todo(_text,false));
        todo.push(Todo({text: _text, completed: false}));

        Todo memory to ;
        to.text = _text;
        todo.push(to);
    }

    function get(uint256 index) public view returns (string memory text, bool completed){
        Todo storage to = todo[index];
        return (to.text, to.completed);
    }
        function updateText(uint256 index, string calldata _text) public {
        Todo storage to = todo[index];
        to.text = _text;
    }

    function toggleCompleted(uint256 index) public {
        Todo storage to = todo[index];
        to.completed = !to.completed;
    }

}