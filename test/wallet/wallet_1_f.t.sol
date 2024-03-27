// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.24;

// import "forge-std/Test.sol";
// import "forge-std/console.sol";
// import "@hack/wallet/wallet_1.sol";


// contract WalletFuzzTest is Test {
//     Wallet public wallet;
//     address public sender;

//     function init() external {
//         wallet = new Wallet();
//         sender = msg.sender;
//         payable(address(wallet)).transfer(50);
//     }

//     receive() external payable {}

//     function testWithdrawFuzz() public {
//         // Define the range for fuzz testing
//         uint256[] memory amounts = new uint256[](10); // Adjust as needed
//         for (uint256 i = 0; i < amounts.length; i++) {
//             amounts[i] = random() % (address(this).balance + 1); // Generate random withdrawal amounts
//         }

//         for (uint256 i = 0; i < amounts.length; i++) {
//             // Assume that contract has sufficient balance for withdrawal
//             vm.assume(address(this).balance >= amounts[i]);

//             // Call the withdraw function with random withdrawal amounts
//             (bool success, ) = address(wallet).call{value: 0}(abi.encodeWithSignature("withdraw(uint256)", amounts[i]));
//             if (success) {
//                 console.log("Withdrawal successful for amount:", amounts[i]);
//             } else {
//                 console.log("Withdrawal failed for amount:", amounts[i]);
//             }
//         }
//     }
// }

// contract WalletTestFuzz {



// }
