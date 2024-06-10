pragma solidity ^0.8.24;

contract enums {
    enum Status{
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }

    Status public status;

    function get() external view returns (Status) {
        return status;
    }

    function set(Status _status) public {
        status = _status;
    }

    function cancel() public {
        status = status.Canceled;
    }

    function reset() public {
        delete status;
    }
}