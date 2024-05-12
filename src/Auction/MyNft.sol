//SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MyNft is ERC721 {
    constructor() ERC721("MyNft", "MNF") {}

    function mint(address add, uint256 tokenID) external {
        _mint(add, tokenID);
    }
}
