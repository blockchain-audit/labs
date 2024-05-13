pragma solidity ^0.8.24;

contract Math {
    uint constant WAD = 10 ** 18;
    uint constant RAY = 10 ** 27;

    event LogAnswer(string description, uint number);

    constructor() public {}

    function runCalculates() public {
        uint a = 2;
        uint b = 1000;
        uint c = calculateC(a, b);
        emit LogAnswer("c", c);
        emit LogAnswer("c * 7", c * 7);
        emit LogAnswer("c / 7", c / 7);
        uint z = calculateZ(c);
        emit LogAnswer("z", z);
    }

    function calculateC(uint a, uint b) public returns(uint c) {
        c = a * WAD / b;
    }

    function calculateZ(uint c) public returns(uint z) {
        uint number = c + (9 * WAD);
        z = (number * c) / WAD;
    }
}
