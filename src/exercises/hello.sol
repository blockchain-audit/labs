// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.6;

contract HelloWorld {

    function time() view public returns (uint256) {
        return block.timestamp;
    }

}
// Deployer: 0x425a024816fBd7A08c8258357cCfCEB802E2d0cd
// Deployed to: 0xea0167A00c1Bd9691001ed95baC6Dac50D483589
// Transaction hash: 0x18c7b4c433ff0db0332bfd283dd2b5bd2c4864abd29cf1648ce4d760dd6e851f