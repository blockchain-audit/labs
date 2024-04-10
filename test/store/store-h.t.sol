// // SPDX-License-Identifier: Unlicense
// pragma solidity ^0.8.15;

// import "foundry-huff/HuffDeployer.sol";
// import "forge-std/Test.sol";
// import "forge-std/console.sol";

// contract SimpleStoreTest is Test {
//     /// @dev Address of the SimpleStore contract.
//     Store public s;

//     /// @dev Setup the testing environment.
//     function setUp() public {
//         s = Store(HuffDeployer.deploy("store/store"));
//     }

//     /// @dev Ensure that you can set and get the value.
//     function testSetAndGetValue(uint256 value) public {
//         s.setValue(value);
//         console.log(value);
//         console.log(s.getValue());
//         assertEq(value, s.getValue());
//     }
// }

// interface Store {
//     function setValue(uint256) external;
//     function getValue() external returns (uint256);
// }
