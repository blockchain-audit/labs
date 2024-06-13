// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Enums {
    enum Status {
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }

    enum Colors {
        Blue,
        Red,
        Black,
        Grey,
        Yellow,
        Pink
    }
}
