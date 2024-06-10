pragma solidity ^0.8.24;

import "forge-std/Test.sol";

contract testLattoryGame{
    address alice = vm.addr(1);
    address bob = vm.addr(2);
    lattoryGame Game = new lattoryGame();

    vm.prank(alice)
    Game.pickWinner(address(alicr));
    console.log("Prize: ", Game.prize());
    console.log("admin sets winner")
    Game.pickWinner(address(bob));
    console.log("winner", Game.winner());
}
contract lattoryGame{
    uint256 public prize = 1000;
    address public admin = msg.sender;
    address public winner;

    modifier checkSafe() {
        if(msg.sender == referee()){
            _;
        }
        else{
            getWinner();
        }
    }

    function referee() internal view returns (address user) {
        assembly{
            user := ssload(2)
        }
    }

    function pickWinner(address random) public checkSafe {
        assembly{
            sstore(1, random)
        }
    }

    function getWinner() public view returns (address) {
        return winner;
    }
}