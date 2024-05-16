
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

    import "forge-std/console.sol";
    import "@openzeppelin/ERC721/IERC721.sol";
    import "@hack/auction/myAuction.sol";
    import "foundry-huff/HuffDeployer.sol";
    import "forge-std/Test.sol";
    import "forge-std/Vm.sol";
    import "@hack/myTokens/ERC721.sol";

    contract AuctionTest is Test{

        Auction auction;
        MyERC721 token;
        address public highestBidderAddress = address(0);
        uint public highestBid = 0;
        address sellerAddress = address(0x123);
        uint tokenId = 1;
        uint startingPrice = 100;
        uint startTime = block.timestamp;
        uint during = 4;
        bool isStart = false; 

        function setUp() public{
            auction = new Auction();
            token = new MyERC721("MyNft", "NFT");
            token.mint(sellerAddress, tokenId);
        }

        function testSrartAuction() external{
            
        }

        // function testAddBidd() internal{
        // }

        // function testRemoveBidd() public payable{

        // }

        // function testEndAction() public{
        //     console.log(isStart);
        // } 
    }