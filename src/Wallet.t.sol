// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/wallet/wallet.sol";


contract WalletTest is Test {
    Wallet public w;

    // Everything I need to start my test
    function setUp() public {
        w = new Wallet();
    }

    function testAddGabay() public {
        

    }

       function testIsOwner() public {
    }

       function testIsAllowed() public {
    }

       function testWithdraw() public {
        uint256 amount=50 wei;
        uint256 prevBalance=address(w).balance;
        uint256 expectedBalance=prevBalance-amount;

        w.withdraw(amount);

         assertEq(expectedBalance,address(w).balance,"ERROR! the balance didn't decrease after the withdraw");
    }

       function testGetBalance() public {
        uint256 myBalance=address(w).balance;
        uint256 expected=w.getBalance();
        assertEq(myBalance,expected,"ERROR! you should get the balance");
    }

       function testDeletGabay() public {
    }
}
