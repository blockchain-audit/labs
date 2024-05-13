// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
//import "@openzeppelin/contracts/access/Ownable.sol";
contract MyERC721 is ERC721 {
    constructor(string memory name, string memory symbol) ERC721(name, symbol) {}
    function mint(address to, uint256 tokenId) public {
        _mint(to, tokenId);
    }
}