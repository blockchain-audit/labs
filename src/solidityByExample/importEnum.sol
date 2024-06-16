// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./enums.sol";

contract Enum {
    // Default value is the first element listed in
    // definition of the type, in this case 'Pending'
    Status public status;

    function get() public view returns (Status) {
        return status;
    }

    function set(Status _status) public {
        status = _status;
    }

    // update to specific enum
    function cancel() public {
        status = Status.Canceled;
    }

    // dekete reset the enum to be the first
    function reset() public {
        delete status;
    }
}
