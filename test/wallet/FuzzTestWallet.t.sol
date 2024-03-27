// SPDX-License-Identifier: Unlicense
pragma solidity >=0.5.11;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@labs/wallet/WalletGabaiim.sol";

contract FuzzTestWallet is Test {
    WalletGabaiim public wallet;
    address public someRandomUser = vm.addr(1);

    function setUp() public {
        wallet = new WalletGabaiim();
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
        wallet.addGabai(someRandomUser);
        vm.startPrank(someRandomUser);
        payable(address(wallet)).transfer(amount);
        uint256 balance = wallet.balance();
        wallet.withdraw(amount);
        vm.stopPrank();
        assertEq(wallet.balance(), balance - amount);
    }

    function testWithdrawButNoMoney(uint256 amount) public {
        wallet.addGabai(someRandomUser);
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
        vm.expectRevert("sender is not owner or gabai");
        wallet.withdraw(amount);
        vm.stopPrank();
    }

    function testAddGabai(address newGabai) public {
        uint256 count = wallet.countGabaiim();
        wallet.addGabai(newGabai);
        assertTrue(wallet.gabaiim(newGabai));
        assertEq(wallet.countGabaiim(), count + 1);
    }

    function testAddGabaiAlreadyExsist(address newGabai) public {
        wallet.addGabai(newGabai);
        vm.expectRevert("the gabai already exsist");
        wallet.addGabai(newGabai);
    }

    function testAddGabaiMoreThree(address newGabai) public {
        wallet.addGabai(0x562b99aCA39C6e94d93F483E074BBaf5789c87Cd);
        wallet.addGabai(0x29392969D235eA463A6AA42CFD4182ED2ecB5117);
        wallet.addGabai(0x2691200b3624C82757F28B52E4573bB61f6CCFf4);
        if (
            newGabai == 0x562b99aCA39C6e94d93F483E074BBaf5789c87Cd
                || newGabai == 0x29392969D235eA463A6AA42CFD4182ED2ecB5117
                || newGabai == 0x2691200b3624C82757F28B52E4573bB61f6CCFf4
        ) {
            vm.expectRevert("the gabai already exsist");
        } else {
            vm.expectRevert("there are already 3 gabaiim");
        }
        wallet.addGabai(newGabai);
    }

    function testChangeGabai(address oldGabai, address newGabai) public {
        // vm.startPrank(someRandomUser);
        wallet.addGabai(oldGabai);
        if (oldGabai == newGabai) {
            vm.expectRevert("the new gabai already gabai");
            wallet.changeGabai(oldGabai, newGabai);
        }
        else {
            wallet.changeGabai(oldGabai, newGabai);
            assertTrue(wallet.gabaiim(newGabai));
            assertFalse(wallet.gabaiim(oldGabai));
        }

    }

    function testChangeGabaiNotOwner(address oldGabai, address newGabai) public {
        vm.startPrank(someRandomUser);
        vm.expectRevert("You do not have permission to do so");
        wallet.changeGabai(oldGabai, newGabai);
        vm.stopPrank();
    }

    function testChangeGabaiOldNotGabai(address oldGabai, address newGabai) public {
        vm.expectRevert("the adress oldGabai not gabai");
        wallet.changeGabai(oldGabai, newGabai);
    }

    function testChangeGabaiNewAlreadyGabai(address oldGabai, address newGabai) public {
        if (oldGabai != newGabai) {
            wallet.addGabai(newGabai);
            wallet.addGabai(oldGabai);
            vm.expectRevert("the new gabai already gabai");
            wallet.changeGabai(oldGabai, newGabai);
        }
    }
}
