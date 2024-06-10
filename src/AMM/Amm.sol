// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;
import ".././MyToken.sol";

// contract Amm {
// MyToken tokenX;
// MyToken tokenY;
// uint256 amountX;
// uint256 amountY;
// uint256 total;
// // uint256 a;
// // uint256 b;
// address owner;
//     constructor() {
//        total=tokenY* tokenX;
//        owner=msg.sender;
//     }
//     function changeX(uint256 amount) public returns(uint256){
//         amountY=tokenY+amount;
//         amountX=tokenX-(tokenX/amountY);
//         uint256 change=tokenX-amountX;
//         return change;
//     }

//     function changY(uint256 amount) public returns(uint256){
//         amountX=tokenX+amount;
//         amountY=tokenY-(tokenY/amountX);
//         uint256 change=tokenY-amountY;
//         return change;
//     }
// }