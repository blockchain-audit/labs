// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../../src/wallet/walletGabaim.sol";

contract TestFuzzWalletGabaim is Test {
    //מופע לארנק
    WalletGabaim public walletG;
    address public ownerAddress = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;
    address public noOwnerAddress = 0x9876543210987654321098765432109876543210;

    function setUp() public {
        walletG = new WalletGabaim();
        //מכניסה כסף לחוזה חכם שלייי הנוכחייי
        vm.deal(address(this), 100);
    }

    function test_fuzzReceive(uint256 amount) public {
        vm.deal(address(this), amount);
        uint256 balance = walletG.getValue();
        console.log(balance);
        payable(address(walletG)).transfer(amount);
        //check if balance the same ;
        assertEq(walletG.getValue(), balance + amount);
    }
    //    function testChangeOwnerExsist(address oldCollector, address newCollector) public {
    //     vm.expectRevert("you are owner");
    //     walletG.changeOwners(newCollector, oldCollector);
    // }
    //     function testChangeOwner(address oldCollector, address newCollector) public {
    //     // address oldCollector = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    //     // address newCollector = 0x9876543210987654321098765432109876543210;
    //     walletG.changeOwners(newCollector, oldCollector);
    // }
    function test_fuzzWithDrawIsOwner(uint amountWithDraw) public {
        vm.deal(address(walletG), amountWithDraw);
        //  payable(address(walletG)).transfer(200);
        uint balance = address(walletG).balance;
        vm.startPrank(ownerAddress);
        walletG.withDraw(amountWithDraw);
        assertEq(walletG.getValue(), balance - amountWithDraw);
    }
     function test_fuzzWithDrawIsnOwner(uint256 amountWithDraw) public {
        vm.startPrank(noOwnerAddress);
        vm.expectRevert("Only the owner can withdraw");
        walletG.withDraw(amountWithDraw);
        vm.stopPrank();
        // assertEq(walletG.getValue(), balance);
    }
}
