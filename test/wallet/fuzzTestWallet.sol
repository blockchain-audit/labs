pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/wallet/wallet.sol";

contract FuzzTestWallet is Test {
    Wallet public wallet;
    address public owner;
    address public notOwnerAddress;

    function setUp() public {
        wallet = new Wallet();
        owner = address(1234);
        notOwnerAddress = address(2345);
    }

    function testReceive(uint amount) public {
//        vm.deal(address(this))
        vm.startPrank(owner);
        vm.deal(owner, amount);
        uint256 balanceBefore = address(wallet).balance;
        console.log(balanceBefore);
        payable(address(wallet)).transfer(amount);
        uint256 balanceAfter = address(wallet).balance;
        assertEq(balanceAfter - amount, balanceBefore);
    }

    function testWithdraw(uint256 amount) public {
        vm.deal(address(wallet), amount);
        wallet.addOwner(owner);
        vm.startPrank(owner);
        uint256 balanceWallet = address(wallet).balance;
        uint256 balanceOwner = address(owner).balance;
        console.log("balance wallet:", balanceWallet);
        console.log("balance owner", balanceOwner);
        console.log(address(this));
        wallet.withdraw(amount);
        vm.stopPrank();

        assertEq(address(owner).balance - amount, balanceOwner);
        assertEq(address(wallet).balance + amount, balanceWallet);
    }


    function testWithdrawNotOwner(uint256 amount, address add) public {
        vm.startPrank(add);
        vm.assume(add != address(this));
        vm.expectRevert("Sender is not one of the owners");
        wallet.withdraw(amount);
    }
}

