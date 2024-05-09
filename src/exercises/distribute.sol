// // SPDX-License-Identifier: MIT
// // https://medium.com/@marketing.blockchain/how-to-create-a-multisig-wallet-in-solidity-cfb759dbdb35
// pragma solidity ^0.8.20;

// contract Distribute {

//     address[] public addresses = [
//         0xad0091676Fa9631e1A74fE12E4a34325D1EdEB84,
//         0x7a3b914a1f0bD991BAf826F4fE9a47Bb9880d25f,
//         0x057bB196e8f0326AFc453d2bcd1fCfCb4F879AfA,
//         0x21D665Ed3E95a19a19DCaf330e2d12bE0f43144f,
//         0xCfEb056B0C0e2Cf1Cb321B4D22c1E35ee01CdAC7,
//         0x6a877aAdFd3479AFB865b739a09dE17C749a8e36,
//         0xaC4E320Ed1235F185Bc6AC8856Ec7FEA7fF0310d,
//         0xd666bfAD1057952ceb19A61f549a7a9E8b5e9261,
//         0x176CA4Ed2bCEed0B49F28E1ECe6134C9F3a6daD0,
//         0x7c0FA5571c4A1A67FD21Ed9209674868cC8dc86b,
//         0x2691200b3624C82757F28B52E4573bB61f6CCFf4,
//         0x710F7099fFe558091854b0A5Bd88DFc88aD5ac6C,
//         0xad0091676Fa9631e1A74fE12E4a34325D1EdEB84,
//         0x38C6a688D7e357cE98037A4B51E9B3E3237cc9a8,
//         0x09E7D0A2e83C6830CFcaf3C2822a74420D23EB63,
//         0x434d091Ef55054e5fe7e43008A7120f92D471415,
//         0x168e5f2f4D0aBA5f4B4434b9Be4beAF43dc9c5d5,
//         0x53665ADAd4D6f6AF4dC6989b1837786F647a89F1,
//         0x2881A96386DD97c5B4C63956A420e6E1A674Fc44,
//         0x5ced660E3b925f034f99Df9466324F30A8Edf176,
//         0x138b601992D3E744cD2a883bF5a46b3a23D9E7F5,
//         0x57C91e4803E3bF32c42a0e8579aCaa5f3762af71,
//         0x81Ee0c1564B711bDf324295a1f1e02E1920876aD,
//         0x7ae3DbAC75D264B6F6976639ebBfC645601D3F15,
//         0x29392969D235eA463A6AA42CFD4182ED2ecB5117,
//         0x562b99aCA39C6e94d93F483E074BBaf5789c87Cd,
//         0x074AC318E0f004146dbf4D3CA59d00b96a100100,
//         0x68BF2f4E4091C29dFa88B2c8bCBB65f00A63CE04,
//         0xFc9ECA65d2BD19991F46ad73570920B2a7a23831,
//         0x11059Fa68a9a49D683665AafDc93483d74544A47,
//         0x7F4Bf8251F5003bB60cb482c0a59473E1C4428d4
//     ];

//     function distribute() public payable {
//         uint share = msg.value / addresses.length;
// ++++++++++++++++++++++++++++++
//         for (uint i = 0; i < addresses.length; i++) {
//             payable(addresses[i]).transfer(share);
//         }
//     }
// }