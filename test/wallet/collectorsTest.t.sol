// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../../src/wallet/collectorsWallet.sol";

contract CollectorsTest is Test {
    CollectorsWallet public walletGabaim;

    function setUp() public {
        walletGabaim = new CollectorsWallet();
        payable(address(walletGabaim)).transfer(100); // move 100 to the contract
    }

    function testReceive() public {
        uint256 initialBalance = address(walletGabaim).balance; // the balance in the begining (before transfer)
        payable(address(walletGabaim)).transfer(100); // move 100 to the contract
        uint256 finalBalance = address(walletGabaim).balance; // the balance in the final (aftere transfer)
        assertEq(finalBalance, initialBalance + 100);
    }

    function testNotAllowedWithDraw() external {
        uint256 withdrawAmount = 50;
        address userAddress = vm.addr(12); // address of not allowed user
        vm.startPrank(userAddress); // send from spec address

        uint256 initialBalance = uint256(address(walletGabaim).balance); // the balance in the begining (before transfer)
        vm.expectRevert();
        walletGabaim.withdraw(withdrawAmount);
        uint256 finalBalance = uint256(address(walletGabaim).balance); // the balance in the final (after transfer)
        assertEq(finalBalance, initialBalance);
        vm.stopPrank();
    }

    function testAllowedWithDraw() external {
        uint256 withdrawAmount = 50;
        address userAddress = 0x7a3b914a1f0bD991BAf826F4fE9a47Bb9880d25f; // address of allowed user
        vm.startPrank(userAddress); // send from user address

        uint256 initialBalance = address(walletGabaim).balance; // the balance in the begining (before transfer)
        walletGabaim.withdraw(withdrawAmount);
        uint256 finalBalance = address(walletGabaim).balance; // the balance in the final (after transfer)
        assertEq(finalBalance, initialBalance - withdrawAmount);
        vm.stopPrank();
    }

    function testUpdateCollectors() public {
        address oldCollector = 0xaC4E320Ed1235F185Bc6AC8856Ec7FEA7fF0310d;
        address newCollector = 0x7ae3DbAC75D264B6F6976639ebBfC645601D3F15;

        address ownerAddress = 0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496; // address of owner user
        vm.startPrank(ownerAddress); // send from owner address
        console.log(address(msg.sender));
        walletGabaim.updateCollectors(oldCollector, newCollector);

        // change again the old Address
        vm.expectRevert();
        walletGabaim.updateCollectors(oldCollector, newCollector);

        assertEq(walletGabaim.collectors(newCollector), 1);
        assertEq(walletGabaim.owner(), 0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496);
        assertEq(walletGabaim.collectors(oldCollector), 0);
        vm.stopPrank();
    }

    function testNotUpdateCollectors() public {
        address oldCollector = 0xaC4E320Ed1235F185Bc6AC8856Ec7FEA7fF0310d;
        address newCollector = 0x7ae3DbAC75D264B6F6976639ebBfC645601D3F15;

        address userAddress = vm.addr(12); // address of user
        vm.startPrank(userAddress); // send from user address
        console.log(address(msg.sender));
        vm.expectRevert();
        walletGabaim.updateCollectors(oldCollector, newCollector);

        assertEq(walletGabaim.collectors(oldCollector), 1);
        vm.stopPrank();
    }

    function testGetBalance() public {
        assertEq(walletGabaim.getBalance(), 100, "not equals");
    }
}
