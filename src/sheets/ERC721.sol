// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.15;

abstract contract ERC721 {
    //events
    event Transfer(address indexed from, address indexed to, uint256 indexed id);

    event Approval(address indexed owner, address indexed spender, uint256 indexed id);

    event ApprovalForAll(address indexed owner, address indexed operator, bool approval);

    // metadata

    string public name;

    string public symbol;

    function tokenURI(uint256 id) public view virtual returns (string memory);

    //
    mapping(uint256 => address) internal _ownerOf;

    mapping(address => uint256) internal _balanceOf;

    function ownerOf(uint256 id) public view virtual returns (address owner) {
        require((owner = _ownerOf[id]) != address(0), "NOT_MINTED");
    }

    function balanceOf(address owner) public view virtual returns (uint256) {
        require(owner != address(0), "ZERO_ADDRESS");

        return _balanceOf[owner];
    }

    //approval

    mapping(uint256 => address) public getApproved;

    mapping(address => mapping(address => bool)) public isApprovedAll;

    //constructor

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    //logic
    function approve(address spender, uint256 tokenId) public virtual {
        require(ownerOf(tokenId) == msg.sender || isApprovedAll[ownerOf(tokenId)][msg.sender] == true, "NOT_AUTHORIZED");

        getApproved[tokenId] = spender;

        emit Approval(ownerOf(tokenId), spender, tokenId);
    }

    function setApprovedForAll(address operator, bool approved) public virtual {
        isApprovedAll[msg.sender][operator] = approved;

        emit ApprovalForAll(msg.sender, operator, approved);
    }

    function transferFrom(address from, address to, uint256 id) public virtual {
        require(from == _ownerOf[id], "WRONG_FROM");

        require(to != address(0), "INVALID_RECIPIENT");
        require(from == msg.sender || isApprovedAll[from][msg.sender] || getApproved[id] == msg.sender);

        unchecked {
            _balanceOf[from]--;

            _balanceOf[to]++;
        }
        _ownerOf[id] = to;

        delete getApproved[id];

        emit Transfer(from, to, id);
    }

    function _mint(address to, uint256 id) internal {
        require(to != address(0));

        require(_ownerOf[id] == address(0));

        _ownerOf[id] = to;

        _balanceOf[to]++;

        emit Transfer(address(0), to, id);
    }

    function _burn(uint256 id) internal {
        address owner = _ownerOf[id];

        _balanceOf[owner]--;

        delete _ownerOf[id];

        delete getApproved[id];

        emit Transfer(owner, address(0), id);
    }
}
