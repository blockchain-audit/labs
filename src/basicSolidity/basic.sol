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

    function doSomething() public view{
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

    function get(address _addr, uint i) public view returns(bool){
        return nested[_addr][i];
    }

    function set(address _addr, uint i, bool _boo) public{
        nested[_addr][i] = _boo;
    }

    function remove(address _addr, uint i) public{
        delete nested[_addr][i];
    }
}

contract Array{
    uint[] public arr;
    uint[] public arr2 = [1 ,2 ,3];
    uint[10] public myFixedSizeArr;

    function get(uint i) public view returns(uint){
        return arr[i];
    }

    function getArr() public view returns(uint256 [] memory){
        return arr;
    }

    function push(uint i) public{
        arr.push(i);
    }

    function pop() public{
        arr.pop();
    }

    function getLength() public view returns(uint256){
        return arr.length;
    }

    function remove(uint index) public {
        delete arr[index];
    }

    function examples() external pure{
        uint [] memory a = new uint[](5);
    }
}

contract ArrayRemoveByShifting{
    uint [] public arr;
 
    function remove(uint _index) public {
        require(_index < arr.length, "index out of bound.");
        for(uint i = _index; i < arr.length - 1; i ++){
            arr[i] = arr[i + 1];
        }
        arr.pop();
    }

    function test() external {
        arr = [1, 2, 3, 4, 5];
        remove(2); // [1, 2, 4, 5]
        assert(arr[0] == 1);
        assert(arr[1] == 2);
        assert(arr[2] == 4);
        assert(arr[3] == 5);
        assert(arr.length == 4);
        arr = [1];
        remove(0); // []
        assert(arr.length == 0);
    }
}

contract ArrayReplaceFromEnd{
    uint [] public arr;

    function remove(uint index) public {

        arr[index] = arr[arr.length -1];
        // Remove the last element
        arr.pop();
    }

    function test() public {
        arr = [1, 2, 3, 4];

        remove(1); // [1, 4, 3]

        assert(arr.length == 3);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
        assert(arr[2] == 3);

        remove(2); // [1, 4]

        assert(arr.length == 2);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
        

    }
}

contract Enum {
    enum Status{
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }

    Status public status;

    function get() public view returns(Status) {
         return status;
    }

    function set(Status _status) public {
        status = _status;
    }

    function cnacel() public {
        status = Status.Canceled;
    }

    function reset() public {
        delete status;
    }
}

contract Todos{
    struct Todo{
        string text;
        bool completed;
    }

    Todo[] public todos;

    function create(string calldata _text) public {
        // 3 ways to initialize a struct
        todos.push(Todo(_text, false));

        todos.push(Todo({text: _text, completed: false}));

        Todo memory todo;

        todo.text = _text;
        todo.completed = false;
        todos.push(todo);
    }

    function get(uint _index) public view returns(string memory, bool completed){
        Todo storage todo = todos[_index];
        return (todo.text, todo.completed);
    }

    function updateText(uint _index, string calldata _text) public {
        Todo storage todo = todos[_index];
        todo.text = _text;
    }

    function toggleCompleted(uint _index) public {
        Todo storage todo = todos[_index];
        todo.completed = !todo.completed;
    }
}

// Storage : אכסון בזיכרון חיצוני 
// קבוע ומשמש לאחסון נתונים לאורך חיי החוזה החכם. נתונים המאוחסנים בזיכרון זה נשמרים גם לאחר סיום ביצוע הפונקציה

// Memory : איכסון פנימי - זיכרון זמני 
// משמש רק במהלך ביצוע הפונקציה. כל הנתונים המאוחסנים בזיכרון נמחקים כאשר הפונקציה מסתיימת.
// משתנים המוגרים כך זמניים ונמצאים בשימוש רק בתוך הפונקציה או הקריאות הפנימיות שלה.

//Calldata : זיכרון המשמש לקריאה בלבד ואינו ניתן לשינוי
// יעיל עבור פרמטרים של פונקציות חיצוניות
// יעיל יותר לשימוש בקריאות חוזרות בגלל שהוא לא יוצר עותק של הנתונים
// משמש לאחסון נתונים שהתקבלו מהקריאה לפונקציה. מיועד לפרמטרים של פונקציות ציבוריות


contract DataLocations {
    
    uint256 [] public arr;

    mapping(uint256 => address) map;

    struct MyStruct {
        uint256 foo;
    }

    mapping(uint256 => MyStruct) myStructs;

    function f() public {
       _f(arr, map, myStructs[1]);

        MyStruct storage myStruct = myStructs[1];

        MyStruct memory myMemStruct = MyStruct(0);
    }

    function _f(uint[] storage _arr, mapping(uint => address) storage _map, MyStruct storage _myStruct) internal {
        arr[1] = 1;
        _map[1] = address(1);
        _myStruct.foo = 5;
    }

    function g(uint [] memory _arr) public pure returns (uint[] memory) {
        _arr[0] = 1;
        return _arr;
    }

    function h(uint [] calldata _arr) external pure{
        uint num = _arr[0];
    }
}
  
    //Make sure EVM version and VM set to Cancun

    // Storage - data is stored on the blockchain
    // Memory - data is cleared out after a function call
    // Transient storage - data is cleared out after a transaction
    interface ITest {
        function val() external view returns(uint);
        function test() external;
    }
   
    contract Callback {
        uint public val;

        fallback() external {
            val = ITest(msg.sender).val();
        }
        
        function test(address target) external {
            ITest(target).test();
        }
    }

    contract TestStorage {
        uint public val;

        function test() public {
            val = 123;
            bytes memory b = "";
            msg.sender.call(b);
        }
    }

    contract TestTransientStorage {
        bytes32 constant SLOT = 0;

        function test() public {
            assembly {
                tstore(SLOT, 321)
            }
            bytes memory b = "";
            msg.sender.call(b);
        }

        function val() public view returns(uint256 v){
            assembly {
                v := tload(SLOT)
            }
        }
    }

    contract ReentrancyGuard {
        bool private locked;

        modifier lock() {
            require(!locked);
            locked = true;
            _;
            locked = false;
        }

        // 35313 gas
        function test() public lock {
            bytes memory b = "";
           msg.sender.call(b);
        }
    }

    // contract ReentrancyGuardTransient {
    //     bytes constant SLOT = 0;

    //     modifier lock() {
    //         assembly {
    //             // revert(0, 0)  טווח הנתונים שהפונקציה revert תיקח ממקום בזיכרון כדי להחזיר, ובמקרה זה מדובר באפס, כלומר אין נתונים להחזיר.
    //             if tload(SLOT) { revert(0, 0)}
    //             tstore(SLOT, 1)
    //         }
    //         _;
    //         assembly {
    //             tstore(SLOT, 0)
    //         }
    //     }

    //     // 21887 gas
    //     function test() external lock {
    //         bytes memory b = "";
    //         msg.sender.call(b);
    //     }
    // }

    contract Function {
        function returnMany() public pure returns (uint, bool, uint) {
            return (1, true, 2);
        }

        function named() public pure returns (uint x, bool b, uint y) {
            return (1, true, 2);
        }
    
        // Return values can be assigned to their name.
        // In this case the return statement can be omitted.
        function assigned() public pure returns (uint x, bool b, uint y) {
            x = 1;
            b = true;
            y = 2;
        }

        function destructuringAssignments() public pure returns (uint, bool, uint, uint, uint) {
            (uint i, bool b, uint j) = returnMany();

            (uint x, , uint y) = (4, 5, 6);

            return (i, b, j, x, y);
        }

        function arrayInput(uint[] memory arr) public {}

        uint[] public arr;

        function arrayOutput() public view returns (uint [] memory) {
            return arr;
        }
    }

       contract XYZ {
         function someFuncWithManyInputs (
            uint x, uint y, uint z, address a, bool b, string memory c) 
            public pure returns (uint){}

            function callFunc() external pure returns (uint) {
                return someFuncWithManyInputs(1, 2, 3, address(0), true, "c");
            }

            function callFuncWithKeyValue() external pure returns (uint) {
                return someFuncWithManyInputs({
                    a: address(0),
                    b: true,
                    c: "c",
                    x: 1,
                    y: 2,
                    z: 3
                });
            }
       }

       contract ViewAndPure {
        uint public x = 1;

        function addTox(uint y) public view returns (uint) {
            return x + y;
        }

        function add(uint i, uint j) public pure returns (uint) {
            return i + j;
        }
    }

    contract Error {
        function testRequire(uint _i) public pure {
            require(_i > 10, "Input must be greater than 10");
        }

        function testRevert(uint _i) public pure {
            if(_i <= 10)
                revert("Input must be greater than 10");
        }

        uint public num;

        function testAssert() public view {
            assert(num == 0);
        }

        error InsufficientBalance(uint balance, uint withdrawAmount);

        function testCustomError(uint _withdrawAmount) public view {
            uint bal = address(this).balance;

            if(bal < _withdrawAmount) {
                revert InsufficientBalance({
                    balance: bal,
                    withdrawAmount: _withdrawAmount
                });
            }
        }
    }

    contract Account {
        uint public balance;
        uint public constant MAX_UINT = 2 ** 256 - 1;

        function deposit(uint _amount) public {
            uint oldBalance = balance;
            uint newBalance = balance + _amount;

            require(newBalance >= oldBalance, "Overflow");
            balance = newBalance;

            assert(balance >= oldBalance);
        }

        function withdraw(uint _amount) public {
            uint oldBalance = balance;

            require(balance >= _amount, "Underflow");

            if(balance < _amount){
                revert("Underflow");
            }

            balance -= _amount;

            assert(balance <= oldBalance);
        }
    }

    contract FunctionModifier{
        address public owner;
        uint public x = 10;
        bool public locked;

        constructor() {
            owner = msg.sender;
        }

        modifier onlyOwner() {
            require(msg.sender == owner, "Not owner");
            _;
        }

        modifier validAddress(address _addr) {
            require(_addr != address(0), "Not valid address");
            _;
        }

        function changeOwner(address _newOwner) public onlyOwner validAddress(_newOwner) {
            owner = _newOwner;
        }

        modifier noReentrancy() {
            require(!locked, "No reentrancy");
            locked = true;
            _;
            locked = false;
        }

        function decrement(uint i) public noReentrancy {
            x -= i;

            if(i > 1) {
                decrement(i - 1);
            }
        }
    }

    contract Event {
        // Up to 3 parameters can be indexed.
        // מאפשרים לרשום נתונים על הבלוקצ'יין שניתן לשאוב ולקרוא מחוץ לחוזה.
        // פרמטרים מסומנים כ-indexed מאפשרים חיפוש ואיתור יעילים יותר של האירועים ביומני הבלוקצ'יין.
        event Log(address indexed sender, string messge);
        event AnotherLog();

        function test() public {
            emit Log(msg.sender, "Hello World!");
            emit Log(msg.sender, "Hello EVM!");
            emit AnotherLog();
        }
    }

    contract X {
        string public name;

        constructor(string memory _name){
            name = _name;
        }
    }

    contract Y {
        string public text;

        constructor(string memory _text) {
            text = _text;
        }
    }

    contract B is X("Input to X"), Y("Input to Y") {}

    contract C is X, Y {
        constructor(string memory _name, string memory _text) X(_name) Y(_text) {}
    }

    contract D is X, Y {
        constructor() X("X was called") Y("Y was called") {}
    }

    contract E is X, Y {
        constructor() Y("Y was called") X("X was called") {}
    }


   contract AA {

        // virtual - פונקציה שניתן לדרוס אותה
        function foo() public pure virtual returns (string memory) {
            return "A";
        }
   } 

   contract BB is AA {
    function foo() public pure virtual override returns(string memory) {
        return "B";
    }
   }

   contract CC is AA {
    function foo() public pure virtual override returns (string memory) {
        return "C";
    }
   }

contract DD is BB, CC {
    
    function foo() public pure override(BB, CC) returns (string memory) {
        return super.foo();
    }
}

contract EE is CC, BB {
    function foo() public pure override(CC, BB) returns (string memory) {
        return super.foo();
    }
}

contract FF is AA, BB {
    function foo() public pure override(AA, BB) returns (string memory) {
        return super.foo();
    }
}


contract AAA {
    string public name = "Contract A";

    function getName() public view returns(string memory) {
        return name;
    }
}

contract CCC is AAA {
    constructor() {
        name = "Contract c";
    }
    // C.getName return "Contract C"
}

