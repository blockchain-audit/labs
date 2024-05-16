// SPDX-License-Identifier: Unlicen
pragma solidity ^0.8.24;

import "/home/user/myToken/new-project/script/myToken.sol";
import "../../src/lendingProtocol/lendingProtocol.sol";
import "forge-std/Test.sol";

contract TestLendingProtocol is Test {
    MyToken daiToken;
    LendingProtocol lendingProtocol;
    address daiTokenAddress;

    function setUp() public {
        daiToken = new MyToken();
        daiTokenAddress = address(daiToken);
        lendingProtocol = new LendingProtocol(daiTokenAddress);
    }

    // Function for users to deposit DAI and receive bond tokens
    function testDeposit() public {
        // Mock deposit amount
        uint256 depositAmount = 100;

        // Mint DAI tokens for testing
        daiToken.mint(address(this), depositAmount);

        // Get the user's DAI balance before depositing
        uint256 balanceBefore = daiToken.balanceOf(address(this));

        // Approve the lendingProtocol contract to spend DAI tokens on behalf of the user
        daiToken.approve(address(lendingProtocol), depositAmount);

        // Deposit DAI tokens to the lendingProtocol contract
        lendingProtocol.deposit(depositAmount);

        // Get the user's DAI balance after depositing
        uint256 balanceAfter = daiToken.balanceOf(address(this));

        // Assert the bondTokens mapping was updated correctly
        assertEq(
            lendingProtocol.bondTokens(address(this)), depositAmount, "Deposit failed: bondTokens mapping not updated"
        );

        // Assert that the DAI balance decreased by the deposit amount
        assertEq(balanceAfter, balanceBefore - depositAmount, "Deposit failed: DAI balance not updated");
    }

    // Function for users to withdraw DAI tokens and reduce their bond tokens
    function testWithdraw() public {
        // Mock deposit amount
        uint256 depositAmount = 100;

        // Mint DAI tokens for testing
        daiToken.mint(address(this), depositAmount);

        // Approve the lendingProtocol contract to spend DAI tokens on behalf of the user
        daiToken.approve(address(lendingProtocol), depositAmount);

        // Deposit DAI tokens to the lendingProtocol contract
        lendingProtocol.deposit(depositAmount);

        // Get the user's DAI balance before withdrawing
        uint256 balanceBefore = daiToken.balanceOf(address(this));

        // Withdraw DAI tokens from the lendingProtocol contract
        lendingProtocol.withdraw(depositAmount);

        // Get the user's DAI balance after withdrawing
        uint256 balanceAfter = daiToken.balanceOf(address(this));

        // Assert the bondTokens mapping was updated correctly
        assertEq(lendingProtocol.bondTokens(address(this)), 0, "Withdraw failed: bondTokens mapping not updated");

        // Assert that the DAI balance increased by the withdrawn amount
        assertEq(balanceAfter, balanceBefore + depositAmount, "Withdraw failed: DAI balance not updated");
    }

    function testNotWithdraw() public {
        // Mock deposit amount
        uint256 depositAmount = 100;

        // Mint DAI tokens for testing
        daiToken.mint(address(this), depositAmount);

        // Approve the lendingProtocol contract to spend DAI tokens on behalf of the user
        daiToken.approve(address(lendingProtocol), depositAmount);

        // Deposit DAI tokens to the lendingProtocol contract
        lendingProtocol.deposit(depositAmount);

        // Expect revert since the withdrawal amount exceeds the available balance
        vm.expectRevert();
        lendingProtocol.withdraw(depositAmount + 1);
    }
}
