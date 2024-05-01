// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC165 {
    function supportsInterface(bytes4 interfaceID) external view returns (bool);
}

interface IERC721 is IERC165 {
    function balanceOf(address owner) external view returns (uint balance);

    function ownerOf(uint tokenId) external view returns (address owner);

    function safeTransferFrom(address src, address dst, uint tokenId) external;

    function safeTransferFrom(
        address src,
        address dst,
        uint tokenId,
        bytes calldata data
    ) external;

    function transferFrom(address src, address dst, uint tokenId) external;

    function approve(address dst, uint tokenId) external;

    function getApproved(uint id) external view returns (address operator);

    function setApprovalForAll(address operator, bool _approved) external;

    function isApprovedForAll(
        address owner,
        address operator
    ) external view returns (bool);
}

interface IERC721Receiver {
    function onERC721Received(
        address operator,
        address src,
        uint tokenId,
        bytes calldata data
    ) external returns (bytes4);
}
