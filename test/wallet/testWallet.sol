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
        wallet.withdraw(1);
        vm.stopPrank();
        vm.startPrank(notOwnerAddress);
        vm.expectRevert("Sender is not one of the owners");
        wallet.withdraw(20);
    }

}

