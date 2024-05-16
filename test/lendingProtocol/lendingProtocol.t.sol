// SPDX-License-Identifier: Unlicen
pragma solidity ^0.8.24;

import "../../src/lendingProtocol/lendingProtocol.sol";
import "openzeppelin-tokens/ERC721/ERC721.sol";
import "openzeppelin-tokens/ERC20/ERC20.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

// Mock ERC20 contract for testing purposes
contract MockERC20 is ERC20 {
    constructor() ERC20("Mock ERC20", "MERC") {
        _mint(msg.sender, 10000 * 10 ** decimals());
    }
}

contract TestLendingProtocol is Test {
    LendingProtocol lendingProtocol;
    ERC20 daiToken;

    function beforeEach() public {
        // Deploy the LendingProtocol contract
        daiToken = new MockERC20();
        lendingProtocol = new LendingProtocol(address(daiToken));
    }

    function testDeposit() public {
        // Mock deposit amount
        uint256 depositAmount = 100;

        // Approve the lendingProtocol contract to spend DAI tokens on behalf of the user
        daiToken.approve(address(lendingProtocol), depositAmount);

        // Deposit DAI tokens to the lendingProtocol contract
        lendingProtocol.deposit(depositAmount);

        // Assert the bondTokens mapping was updated correctly
        assertEq(lendingProtocol.bondTokens(address(this)), depositAmount, "Deposit failed: bondTokens mapping not updated");
    }

    function testWithdraw() public {
        // Mock deposit amount
        uint256 depositAmount = 100;

        // Approve the lendingProtocol contract to spend DAI tokens on behalf of the user
        daiToken.approve(address(lendingProtocol), depositAmount);

        // Deposit DAI tokens to the lendingProtocol contract
        lendingProtocol.deposit(depositAmount);

        // Withdraw DAI tokens from the lendingProtocol contract
        lendingProtocol.withdraw(depositAmount);

        // Assert the bondTokens mapping was updated correctly
        assertEq(lendingProtocol.bondTokens(address(this)), 0, "Withdraw failed: bondTokens mapping not updated");
    }
}
