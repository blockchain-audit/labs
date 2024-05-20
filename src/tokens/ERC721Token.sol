// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

import "forge-std/interfaces/IERC721.sol";

contract ERC721Token is IERC721 {

    event Transfer (address indexed from, address indexed to, uint indexed id);

    event Approval (address indexed owner, address indexed spender, uint indexed id);

    event ApprovalForAll (address indexed owner, address indexed operator, bool approved);

    string public name;
    string public symbol;

    function tokenURI(uint id) public view virtual returns (string memory);

    mapping(uint => address) internal _ownerOf;
    mapping (address => uint) internal _balanceOf;

    function ownerOf(uint id) public view virtual returns (address owner) {
        require((owner = _ownerOf[id])!= address(0), "NOT_MINTED");
    }


    function balanceOf(address owner) public view virtual returns (uint256) {
        require(owner != address(0), "ZERO_ADDRESS");

        return _balanceOf[owner];
    }

    mapping(uint => address) public getApproved;

    mapping(address => mapping(address => bool)) public isApprovedForAll;

    constructor (string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    function approve(address spender, uint id) public virtual {
        address owner = _ownerOf[id];

        require(msg.sender == owner || isApprovedForAll[owner][msg.sender], "NOT_AUTHORIZED");

        getApproved[id] = spender;

        emit Approval(owner, spender, id);
    }

    function setApprovalForAll(address operator, bool approved) public virtual {
        isApprovedForAll[msg.sender][operator] = approved;

        emit ApprovalForAll(msg.sender, operator, approved);
    }

    function transferFrom(address from, address to, uint id) public virtual {
        require (from == _ownerOf[id], "WRONG_FROM");

        require (to != address(0), "INVALID_RECIPIENT");

        require (msg.sender == from || isApprovedForAll[from][msg.sender] || msg.sender == getApproved[id], "NOT_AUTHORIZED");

        unchecked {
            _balanceOf[from] --;
            _balanceOf[to] ++;
        }

        _ownerOf[id] = to;

        delete getApproved[id];

        emit Transfer(from, to, id);
    }

    // function safeTransferFrom(address from, address to, uint id) public virtual {
    //     transferFrom (from, to, id);

    //     require(
    //         to.code.length == 0 ||
    //             ERC721TokenReceiver(to).onERC721Received(msg.sender, from, id, data) ==
    //             ERC721TokenReceiver.onERC721Received.selector,
    //         "UNSAFE_RECIPIENT"
    //     );
    // }

    function supportsInterface(bytes4 interfaceId) public view virtual returns (bool) {
        return
            interfaceId == 0x01ffc9a7 || // ERC165 Interface ID for ERC165
            interfaceId == 0x80ac58cd || // ERC165 Interface ID for ERC721
            interfaceId == 0x5b5e139f; // ERC165 Interface ID for ERC721Metadata
    }

    function _mint(address to, uint id) public virtual {
        require(to != address(0), "INVALID_RECIPIENT");

        require(_ownerOf[id] == address(0), "ALREADY_MINTED");

        unchecked {
            _balanceOf[to] ++;
        }

        _ownerOf[id] = to;

        emit Transfer(address(0), to, id);
    }

    function _burn(uint id) internal virtual {
        address owner = _ownerOf[id];

        require(owner != address(0), "NOT_MINTED");

        unchecked {
            _balanceOf[owner]--;
        }

        delete _ownerOf[id];
        delete getApproved[id];

        emit Transfer(owner, address(0), id);
    }

    //     function _safeMint(address to, uint256 id) internal virtual {
    //     _mint(to, id);

    //     require(
    //         to.code.length == 0 ||
    //             ERC721TokenReceiver(to).onERC721Received(msg.sender, address(0), id, "") ==
    //             ERC721TokenReceiver.onERC721Received.selector,
    //         "UNSAFE_RECIPIENT"
    //     );
    // }

    // function _safeMint(
    //     address to,
    //     uint256 id,
    //     bytes memory data
    // ) internal virtual {
    //     _mint(to, id);

    //     require(
    //         to.code.length == 0 ||
    //             ERC721TokenReceiver(to).onERC721Received(msg.sender, address(0), id, data) ==
    //             ERC721TokenReceiver.onERC721Received.selector,
    //         "UNSAFE_RECIPIENT"
    //     );
    // }
}

/// @notice A generic interface for a contract which properly accepts ERC721 tokens.
/// @author Solmate (https://github.com/transmissions11/solmate/blob/main/src/tokens/ERC721.sol)
abstract contract ERC721TokenReceiver {
    function onERC721Received(
        address,
        address,
        uint256,
        bytes calldata
    ) external virtual returns (bytes4) {
        return ERC721TokenReceiver.onERC721Received.selector;
    }
}