// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Enum {

    enum Status {
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Cancelled
    }

    Status public status;

    function getStatus() public view returns (Status)
    {
        return status;
    }

    function setStatus(Status _status) public
    {
        status = _status;
    }

    function cancel() public
    {
        status = Status.Cancelled;
    }

    function reset() public
    {
        delete status;
    }
}