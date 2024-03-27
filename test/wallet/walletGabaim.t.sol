// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../../src/wallet/walletGabaim.sol";

contract TestWalletGabaim is Test {
    //מופע לארנק
    WalletGabaim public walletG;

    address public ownerAddress = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;
    address public noOwnerAddress = 0x9876543210987654321098765432109876543210;

    function setUp() public {
        walletG = new WalletGabaim();
        //מכניסה כסף לחוזה חכם שלייי הנוכחייי
        vm.deal(address(this), 100);
        // מעבירה לארנק חלק מהכסף שנמצא בכתובת
    }
    function testReceive() public {
        uint256 balance = walletG.getValue();
        uint256 amount = 50;
        payable(address(walletG)).transfer(amount);
        //check if balance the same ;
        assertEq(walletG.getValue(), balance + amount);
    }

    function testChangeOwnerExsist() public {
        address oldCollector = 0x9876543210987654321098765432109876543210;
        address newCollector = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
        vm.expectRevert("you are owner");
        walletG.changeOwners(newCollector, oldCollector);
    }
    function testChangeOwner() public {
        address oldCollector = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
        address newCollector = 0x9876543210987654321098765432109876543210;
        walletG.changeOwners(newCollector, oldCollector);
    }
    function testwithDrawIsnOwner() public {
        uint256 amountWithDraw = 50;
        vm.startPrank(noOwnerAddress);
        vm.expectRevert("Only the owner can withdraw");
        walletG.withDraw(amountWithDraw);
        vm.stopPrank();
        // assertEq(walletG.getValue(), balance);
    }
    function testwithDrawIsOwner() public {
        //  payable(address(walletG)).transfer(200);
        vm.deal(address(walletG), 200);
        //  payable(address(walletG)).transfer(200);
        uint256 amountWithDraw = 50;
        uint balance = address(walletG).balance;
        vm.startPrank(ownerAddress);
        walletG.withDraw(amountWithDraw);
        assertEq(walletG.getValue(), balance - amountWithDraw);
    }
}
