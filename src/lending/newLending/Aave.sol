// // SPDX-License-Identifier: MIT
// pragma solidity >=0.5.11;

// import "openzeppelin-tokens/ERC20/IERC20.sol";
// import "./interfaces/Ipool.sol";
// import "./interfaces/IWETHGateway.sol";
// import "./Lending.sol";

// contract Aave {
//     IERC20 public constant dai = IERC20(0x77FDe93fEe5fe272dC17d799cb61447431E6Eba2);
//     Ipool public constant aave = Ipool(0x685b86a6659a1CbcfE168304386e1b54C543Ce16);
//     IWETHGateway public constant fantomGateway = IWETHGateway(0xd2B0C9778d088Fc79C28Da719bC02158E64796bD);

//     function depositDaiToAave(uint256 amount) public {
//         // dai.approve(address(aave), amount);
//         aave.deposit(address(dai), amount, msg.sender, 0);
//     }

//     function withdrawDaiFromAave(uint256 amount) external {
//         aave.withdraw(address(dai), amount, msg.sender);
//     }

//     function depositFTMToAave(uint amount) external {
//         fantomGateway.depositETH{value: amount}(address(aave), msg.sender, 0);
//     }

//     function withdrawFTMFromAave(uint256 amount) external {
//         fantomGateway.withdrawETH(address(aave), amount, msg.sender);
//     }
// }
