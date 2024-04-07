// SPDX-License-Identifier: Unlicense
pragma solidity >=0.5.11;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@labs/wallet/Wallet.sol";

contract TestWallet is Test {
    Wallet public wallet;
    address public someRandomUser = vm.addr(1);

    function setUp() public {
        wallet = new Wallet();
        payable(address(wallet)).transfer(100);
        wallet.addOwner(0xCfEb056B0C0e2Cf1Cb321B4D22c1E35ee01CdAC7);
    }

    function testReceive() public {
        uint256 balance = wallet.balance();
        payable(address(wallet)).transfer(20);
        assertEq(wallet.balance(), balance + 20);
    }

    function testWithdraw() public {
        uint256 balance = wallet.balance();
        vm.startPrank(0xCfEb056B0C0e2Cf1Cb321B4D22c1E35ee01CdAC7);
        wallet.withdraw(20);
        vm.stopPrank();
        assertEq(wallet.balance(), balance - 20);
    }

    function testWithdrawButNoMoney() public {
        uint256 balance = wallet.balance();
        vm.startPrank(0xCfEb056B0C0e2Cf1Cb321B4D22c1E35ee01CdAC7);
        vm.expectRevert("Not Enough Money in wallet");
        wallet.withdraw(balance + 1);
        vm.stopPrank();
    }

    function testWithdrawNotAuthorized() public {
        vm.startPrank(someRandomUser);
        vm.expectRevert("sender is not owner");
        wallet.withdraw(20);
        vm.stopPrank();
    }

    function testAddOwner() public {
        uint256 count = wallet.countOwners();
        wallet.addOwner(0x074AC318E0f004146dbf4D3CA59d00b96a100100);
        assertTrue(wallet.owners(0x074AC318E0f004146dbf4D3CA59d00b96a100100));
        assertEq(wallet.countOwners(), count + 1);
    }

    function testAddOwnerAlreadyExsist() public {
        vm.expectRevert("the owner already exsist");
        wallet.addOwner(0xCfEb056B0C0e2Cf1Cb321B4D22c1E35ee01CdAC7);
    }

    function testAddOwnerMoreThree() public {
        wallet.addOwner(0x562b99aCA39C6e94d93F483E074BBaf5789c87Cd);
        wallet.addOwner(0x29392969D235eA463A6AA42CFD4182ED2ecB5117);
        vm.expectRevert("there are already 3 owners");
        wallet.addOwner(0x7ae3DbAC75D264B6F6976639ebBfC645601D3F15);
    }

    function testChangeOwner() public {
        wallet.changeOwner(0xCfEb056B0C0e2Cf1Cb321B4D22c1E35ee01CdAC7, 0x7ae3DbAC75D264B6F6976639ebBfC645601D3F15);
        assertTrue(wallet.owners(0x7ae3DbAC75D264B6F6976639ebBfC645601D3F15));
        assertFalse(wallet.owners(0xCfEb056B0C0e2Cf1Cb321B4D22c1E35ee01CdAC7));
    }

    function testChangeOwnerNotMainOwner() public {
        vm.startPrank(someRandomUser);
        vm.expectRevert("You do not have permission to do so");
        wallet.changeOwner(0xCfEb056B0C0e2Cf1Cb321B4D22c1E35ee01CdAC7, 0x7ae3DbAC75D264B6F6976639ebBfC645601D3F15);
        vm.stopPrank();
    }

    function testChangeOwnerOldNotOwner() public {
        vm.expectRevert("the adress oldOwner not owner");
        wallet.changeOwner(0x7ae3DbAC75D264B6F6976639ebBfC645601D3F15, 0x38C6a688D7e357cE98037A4B51E9B3E3237cc9a8);
    }

    function testChangeOwnerNewAlreadyOwner() public {
        wallet.addOwner(0x7ae3DbAC75D264B6F6976639ebBfC645601D3F15);
        vm.expectRevert("the new owner already owner");
        wallet.changeOwner(0x7ae3DbAC75D264B6F6976639ebBfC645601D3F15, 0xCfEb056B0C0e2Cf1Cb321B4D22c1E35ee01CdAC7);
    }
}
