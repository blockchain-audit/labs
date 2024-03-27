pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/wallet/wallet.sol";

contract TestWallet is Test {
    Wallet public wallet;
    address public owner;
    address public notOwnerAddress;

    function setUp() public {
        wallet = new Wallet();
        owner = address(1234);
        notOwnerAddress = address(2345);
        vm.deal(owner, 100);
    }

    function testReceive() public {
        vm.startPrank(owner);
        uint256 balanceBefore = address(wallet).balance;
        payable(address(wallet)).transfer(1);
        uint256 balanceAfter = address(wallet).balance;
        assertEq(balanceAfter - 1, balanceBefore);
    }

    function testWithdraw() public {
        wallet.addOwner(owner);
        vm.startPrank(owner);
        payable(address(wallet)).transfer(100);
        uint256 balanceWallet = address(wallet).balance;
        uint256 balanceOwner = address(owner).balance;
        wallet.withdraw(1);
        vm.stopPrank();

        assertEq(address(owner).balance - 1, balanceOwner);
        assertEq(address(wallet).balance + 1, balanceWallet);
    }

    function testWithdrawNotOwner() public {
        vm.startPrank(notOwnerAddress);
        vm.expectRevert("Sender is not one of the owners");
        wallet.withdraw(1);
    }

    function testAddOwner() public {
        address owner1 = address(5678);
        uint countOwners;
        wallet.addOwner(owner1);
        assertTrue(wallet.owners(owner1));
        assertEq(wallet.countOwners(), countOwners + 1);
    }

    function testAddOwnerNotMain() public {
        vm.startPrank(owner);
        vm.expectRevert("Only mainOwner can add another owner");
        wallet.addOwner(notOwnerAddress);
    }

    function testAddOwnerAlreadyExist() public {
        wallet.addOwner(owner);
        vm.expectRevert("The owner is already exist");
        wallet.addOwner(owner);
    }

    function testAddOwnerMoreThenThree() public {
        wallet.addOwner(owner);
        wallet.addOwner(address(7));
        wallet.addOwner(address(8));
        vm.expectRevert("There are already 3 owners");
        wallet.addOwner(address(9));
        console.log("number of owners:", wallet.countOwners());
    }
}

