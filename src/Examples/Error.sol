// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract Error {
    function testRequire(uint256 _i) public pure {
        require(_i > 10, "nput must be greater than 10");
    }

    function testRevert(uint256 _i) public pure {
        if (_i <= 10) {
            revert("Input must be greater than 10");
        }
    }

    uint256 public num;

    function testAssert() public view {
        assert(num == 0);
    }

    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);

    function testCustomError(uint256 _withdrawAmount) public view {
        uint256 bal = address(this).balance;
        if (bal < _withdrawAmount) {
            revert InsufficientBalance({balance: bal, withdrawAmount: _withdrawAmount});
        }
    }
}

contract Account {
    uint256 public balance;
    uint256 public constant MAX_UINT = 2 ** 256 - 1;

    function deposit(uint256 _amount) public {
        uint256 oldBalance = balance;
        uint256 newBalance = balance + _amount;
        require(newBalance >= oldBalance, "Overflow");
        balance = newBalance;
        assert(balance >= oldBalance);
    }

    function withdraw(uint256 _amount) public {
        uint256 oldBalance = balance;
        require(balance >= _amount, "Underflow");
        if (balance < _amount) {
            revert("Underflow");
        }
        balance -= _amount;
        assert(balance <= oldBalance);
    }
}
