pragma solidity ^0.8.20;

import "@openzeppelin/ERC721/ERC721.sol";

contract MyNFT is ERC721 {
    constructor(string memory name, string memory symbol) ERC721(name, symbol) { }

    function mint(address myAddress, uint tokenId) external {
        _mint(myAddress, tokenId);
    }
}