// SPDX-License-Identifier: Unlicense
pragma solidity >=0.5.11;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@labs/wallet/WalletGabaiim.sol";

contract TestWalletGabaiim is Test {
    WalletGabaiim public wallet;
    address public someRandomUser = vm.addr(1);

    function setUp() public {
        vm.startPrank(someRandomUser);
        wallet = new WalletGabaiim();
        vm.deal(someRandomUser, 200);
        payable(address(wallet)).transfer(100);
        wallet.addGabai(0xCfEb056B0C0e2Cf1Cb321B4D22c1E35ee01CdAC7);
        vm.stopPrank();
    }

    function testReceive() public {
        uint balance = wallet.balance();
        vm.startPrank(someRandomUser);
        payable(address(wallet)).transfer(20);
        vm.stopPrank();
        assertEq(wallet.balance(), balance + 20);
    }

    function testWithdraw() public {
        vm.startPrank(someRandomUser);
        wallet.withdraw(50);
        vm.stopPrank();
        assertEq(wallet.balance(), 50);
    }

    function testWithdrawButNoMoney() public {
        vm.startPrank(someRandomUser);
        vm.expectRevert("Not Enough Money in wallet");
        wallet.withdraw(120);
        vm.stopPrank();
    }

    function testWithdrawNotAuthorized() public {
        address rendomUser = vm.addr(12);
        vm.startPrank(rendomUser);
        vm.expectRevert("sender is not owner or gabai");
        wallet.withdraw(20);
        vm.stopPrank();
    }

    function testAddGabai() public {
        uint count = wallet.countGabaiim();
        vm.startPrank(someRandomUser);
        wallet.addGabai(0x074AC318E0f004146dbf4D3CA59d00b96a100100);
        assertTrue(wallet.gabaiim(0x074AC318E0f004146dbf4D3CA59d00b96a100100));
        assertEq(wallet.countGabaiim(), count + 1);
        vm.stopPrank();
    }

    function testAddGabaiAlreadyExsist() public {
        vm.startPrank(someRandomUser);
        vm.expectRevert("the gabai already exsist");
        wallet.addGabai(0xCfEb056B0C0e2Cf1Cb321B4D22c1E35ee01CdAC7);
        vm.stopPrank();
    }

    function testAddGabaiMoreThree() public {
        vm.startPrank(someRandomUser);
        wallet.addGabai(0x562b99aCA39C6e94d93F483E074BBaf5789c87Cd);
        wallet.addGabai(0x29392969D235eA463A6AA42CFD4182ED2ecB5117);
        vm.expectRevert("there are already 3 gabaiim");
        wallet.addGabai(0x7ae3DbAC75D264B6F6976639ebBfC645601D3F15);
        vm.stopPrank();
    }

    function testChangeGabai() public {
        vm.startPrank(someRandomUser);
        wallet.changeGabai(
            0xCfEb056B0C0e2Cf1Cb321B4D22c1E35ee01CdAC7,
            0x7ae3DbAC75D264B6F6976639ebBfC645601D3F15
        );
        assertTrue(wallet.gabaiim(0x7ae3DbAC75D264B6F6976639ebBfC645601D3F15));
        assertFalse(wallet.gabaiim(0xCfEb056B0C0e2Cf1Cb321B4D22c1E35ee01CdAC7));
        vm.stopPrank();
    }

    function testChangeGabaiNotOwner() public {
        address rendomUser = vm.addr(12);
        vm.startPrank(rendomUser);
        vm.expectRevert("You do not have permission to do so");
        wallet.changeGabai(
            0xCfEb056B0C0e2Cf1Cb321B4D22c1E35ee01CdAC7,
            0x7ae3DbAC75D264B6F6976639ebBfC645601D3F15
        );
        vm.stopPrank();
    }

    function testChangeGabaiOldNotGabai() public {
        vm.startPrank(someRandomUser);
        vm.expectRevert("the adress oldGabai not gabai");
        wallet.changeGabai(
            0x7ae3DbAC75D264B6F6976639ebBfC645601D3F15,
            0x38C6a688D7e357cE98037A4B51E9B3E3237cc9a8
        );
        vm.stopPrank();
    }

    function testChangeGabaiNewAlreadyGabai() public {
        vm.startPrank(someRandomUser);
        wallet.addGabai(0x7ae3DbAC75D264B6F6976639ebBfC645601D3F15);
        vm.expectRevert("the new gabai already gabai");
        wallet.changeGabai(
            0x7ae3DbAC75D264B6F6976639ebBfC645601D3F15,
            0xCfEb056B0C0e2Cf1Cb321B4D22c1E35ee01CdAC7
        );
        vm.stopPrank();
    }
}
