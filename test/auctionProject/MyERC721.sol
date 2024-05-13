// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";


contract MyERC721 is ERC721{

    constructor() ERC721("ERC721", "ERC") {
    }

    function mint(address to, uint256 tokenId) external {
        _mint(to, tokenId);
    }

}