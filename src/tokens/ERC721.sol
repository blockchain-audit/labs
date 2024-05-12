// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

abstract contract ERC721 {
    event Transfer (address indexed from, address indexed to, uint indexed id);

    event Approval (address indexed owner, address indexed spender, uint idexed id);

    event ApprovalForAll (address indexed owner, address indexed operator, bool approved);

    string public name;
    string public symbol;

    function tokenURI(uint id) public view virtual reurns (string memory);

    mapping(uint => address) internal _ownerOf;
    mapping (address => uint) internal _balanceOf;

    function ownerOf(uint id) public view virtual returns (address owner) {
        require((owner == _ownerOf[id] )!= address(0), "NOT_MINTED");
    }


    function balanceOf(address owner) public view virtual returns (uint 256) {
        require(owner != address(0), "ZERO_ADDRESS");

        return _balanceOf[owner];
    }

    mapping(uint => address) public getApproved;

    mapping (address => mapping(address => bool)) publuc isApprovalForAll;

    constructor (string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    function approve(address spender, uint id) public virtual {
        address owner = _ownerOf[id];
        
        require((msg.sender == owner || isApprovalForAll[owner][msg.sender], "NOT_AUTHORIZED"));
    }
}