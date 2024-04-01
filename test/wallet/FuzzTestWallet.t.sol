// SPDX-License-Identifier: Unlicense
pragma solidity >=0.5.11;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@labs/wallet/Wallet.sol";

contract FuzzTestWallet is Test {
    Wallet public wallet;
    address public someRandomUser = vm.addr(1);

    function setUp() public {
        wallet = new Wallet();
    }

    function testReceive(uint256 amount) public {
        uint256 balance = wallet.balance();
        vm.startPrank(someRandomUser);
        vm.deal(someRandomUser, amount);
        payable(address(wallet)).transfer(amount);
        vm.stopPrank();
        assertEq(wallet.balance(), balance + amount);
    }

    function testWithdraw(uint256 amount) public {
        vm.deal(someRandomUser, amount);
        wallet.addOwner(someRandomUser);
        vm.startPrank(someRandomUser);
        payable(address(wallet)).transfer(amount);
        uint256 balance = wallet.balance();
        wallet.withdraw(amount);
        vm.stopPrank();
        assertEq(wallet.balance(), balance - amount);
    }

    function testWithdrawButNoMoney(uint256 amount) public {
        wallet.addOwner(someRandomUser);
        vm.startPrank(someRandomUser);
        if (amount != 0) {
            vm.expectRevert("Not Enough Money in wallet");
        }
        wallet.withdraw(amount);
        vm.stopPrank();
    }

    function testWithdrawNotAuthorized(uint256 amount) public {
        address rendomUser = vm.addr(12);
        vm.startPrank(rendomUser);
        vm.expectRevert("sender is not owner");
        wallet.withdraw(amount);
        vm.stopPrank();
    }

    function testAddOwner(address newOwner) public {
        uint256 count = wallet.countOwners();
        wallet.addOwner(newOwner);
        assertTrue(wallet.owners(newOwner));
        assertEq(wallet.countOwners(), count + 1);
    }

    function testAddOwnerAlreadyExsist(address newOwner) public {
        wallet.addOwner(newOwner);
        vm.expectRevert("the owner already exsist");
        wallet.addOwner(newOwner);
    }

    function testAddOwnerMoreThree(address newOwner) public {
        wallet.addOwner(0x562b99aCA39C6e94d93F483E074BBaf5789c87Cd);
        wallet.addOwner(0x29392969D235eA463A6AA42CFD4182ED2ecB5117);
        wallet.addOwner(0x2691200b3624C82757F28B52E4573bB61f6CCFf4);
        if (
            newOwner == 0x562b99aCA39C6e94d93F483E074BBaf5789c87Cd
                || newOwner == 0x29392969D235eA463A6AA42CFD4182ED2ecB5117
                || newOwner == 0x2691200b3624C82757F28B52E4573bB61f6CCFf4
        ) {
            vm.expectRevert("the owner already exsist");
        } else {
            vm.expectRevert("there are already 3 owners");
        }
        wallet.addOwner(newOwner);
    }

    function testChangeOwner(address oldOwner, address newOwner) public {
        wallet.addOwner(oldOwner);
        if (oldOwner == newOwner) {
            vm.expectRevert("the new owner already owner");
            wallet.changeOwner(oldOwner, newOwner);
        } else {
            wallet.changeOwner(oldOwner, newOwner);
            assertTrue(wallet.owners(newOwner));
            assertFalse(wallet.owners(oldOwner));
        }
    }

    function testChangeOwnerNotOwner(address oldOwner, address newOwner) public {
        vm.startPrank(someRandomUser);
        vm.expectRevert("You do not have permission to do so");
        wallet.changeOwner(oldOwner, newOwner);
        vm.stopPrank();
    }

    function testChangeOwnerOldNotOwner(address oldOwner, address newOwner) public {
        vm.expectRevert("the adress oldOwner not owner");
        wallet.changeOwner(oldOwner, newOwner);
    }

    function testChangeOwnerNewAlreadyOwner(address oldOwner, address newOwner) public {
        if (oldOwner != newOwner) {
            wallet.addOwner(newOwner);
            wallet.addOwner(oldOwner);
            vm.expectRevert("the new owner already owner");
            wallet.changeOwner(oldOwner, newOwner);
        }
    }
}
