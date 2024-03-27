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
        vm.deal(owner, 100);
    }

//    function testReceive(uint256 amount) public {
//        vm.startPrank(owner);
//        uint256 balanceBefore = address(wallet).balance;
//        vm.deal(owner, amount);
//        payable(address(wallet)).transfer(amount);
//        uint256 balanceAfter = address(wallet).balance;
//        assertEq(balanceAfter - amount, balanceBefore);
//    }

//    function testWithdraw(uint256 amount) public         wallet.addOwner(owner);
//        vm.startPrank(owner);
//        vm.deal(owner, amount);
//        payable(address(wallet)).transfer(100);
//        wallet.withdraw(amount);
//        vm.stopPrank();
//        vm.startPrank(notOwnerAddress);
//        vm.expectRevert("Sender is not one of the owners");
//        wallet.withdraw(amount);
//    }

}


