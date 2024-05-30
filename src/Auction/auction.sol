// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// import "../../new-project/lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";
import "../MyToken.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@hack/Auction/MyNft.sol";

contract Auction {
    MyToken public immutable _token;
    MyNft public nft;
    mapping(address => uint256) public bidders;
    mapping(uint256 => address) public indexes;
    uint256 counter;
    uint256 duration = 7 days;
    address public max;
    address payable public owner;
    uint256 private id;
    uint256 immutable wad = 1e18;

    constructor(address Nft, uint256 amount, address tok, uint256 id) {
        _token = MyToken(tok);
        address owner = msg.sender;
        counter = 1;
        nft = MyNft(Nft);
        bidders[owner] = amount * wad;
        max = owner;
        nft.transferFrom(owner, address(this), id);
    }

    function addBidder(uint256 amount) private {
        require(amount * wad > bidders[max], "The value is less than the initial value");
        max = msg.sender;
        _token.transferFrom(msg.sender, address(this), amount);
        bidders[msg.sender] = amount * wad;
        counter += 1;
        indexes[counter] = msg.sender;
    }

    function addBid(uint256 amount) public {
        if (block.timestamp >= duration) {
            endAuction();
        } else {
            addBidder(amount);
        }
    }

    modifier isOwner() {
        require(msg.sender == owner, " isnt owner");
        _;
    }

    function removeOffer() external isOwner {
        require(bidders[msg.sender] != bidders[max], "You cannot withdraw the money because you have the highest value");
        uint256 money = bidders[msg.sender] / wad;
        _token.transferFrom(address(this), msg.sender, bidders[msg.sender] / wad);
        bidders[msg.sender] = 0;
    }

    function endAuction() private {
        bidders[max] = 0;
        while (counter > 0) {
            address bidder = indexes[counter];
            _token.transferFrom(address(this), bidder, bidders[bidder] / wad);
            counter = counter - 1;
        }
        nft.transferFrom(address(this), address(max), id);
    }
}
