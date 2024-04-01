// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "@hack/hack/approve.sol";

/*
Name: Over-Permissive Approve Scam

Description:
This vulnerability is associated with the approval process in ERC20 tokens.
In this scenario, Alice approves Eve to transfer an unlimited (type(uint256).max) amount of tokens
from Alice's account. Later, Eve exploits this permission and transfers 1000 tokens from Alice's account to hers.

Most current scams use approve or setApprovalForAll to defraud your transfer rights. Be especially careful with this part.

Mitigation:
Users should only approve the amount of tokens necessary for the operation at hand.
*/

contract ApproveTest is Test {
    ERC20 token;
    address alice = vm.addr(1);
    address eve = vm.addr(2);

    function testApproveScam() public {
        token = new ERC20();
        token.mint(1000);
        token.transfer(address(alice), 1000);

        vm.prank(alice);
        // Be Careful to grant unlimited amount to unknown
        // website/address.
        // Do not perform approve, if you are sure it's
        // from a legitimate website.
        // Alice granted approval permission to Eve.
        token.approve(address(eve), type(uint256).max);

        console.log("Before exploiting, Balance of Eve:",
                    token.balanceOf(eve));

        console.log("Due to Alice granted permission to Eve,");
        console.log("now Eve can move funds from Alice");

        vm.prank(eve);

        // Now, Eve can move funds from Alice.
        token.transferFrom(address(alice), address(eve), 1000);
        console.log("After exploiting, Balance of Eve:",
                    token.balanceOf(eve));
        console.log("Exploit completed");
    }

    receive() external payable {}
}
