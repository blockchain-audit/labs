// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract LotteryGame {
    uint256 public prize = 1000; // slot 0
    address public winner; // slot 1
    address public admin = msg.sender; // slot 2

    modifier safeCheck() {
        if (msg.sender == referee()) {
            _;
        } else {
            getWinner();
        }
    }

    function referee() public view returns (address user) {
        assembly {
            user := sload(2)
        }
        return user;
    }

    function pickWinner(address guy) public safeCheck {
        assembly {
            sstore(1, guy)
        }
    }

    function getWinner() public view returns (address) {
        return winner;
    }
}
