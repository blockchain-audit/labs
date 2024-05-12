// SPDX-License-Identifier: MIT
pragma solidity >=0.5.11;

import "openzeppelin-tokens/ERC721/ERC721.sol";

contract MyNFT is ERC721 {
    constructor() ERC721("MyNFT", "MNFT") {}

    function mint(address to, uint256 id) public {
        _mint(to, id);
    }
}
