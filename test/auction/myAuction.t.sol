
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

        Auction public auction;
        MyERC721 public token;
        address public sellerAddressT = msg.sender;
        uint public highestBid = 0;
        uint public tokenIdT = 1;
        uint public startingPriceT = 100;
        uint public startTimeT = block.timestamp;
        uint public duringT = 4 days;
        //address public sellerAddress = address(0x00);
        function setUp() public{
            vm.startPrank(sellerAddressT);
            auction = new Auction();
            //auction.sellerAddress() = address(0x123);
            //sellerAddressT = auction.sellerAddress();
            token = new MyERC721("MyNft", "NFT");
            token.mint(sellerAddressT, tokenIdT);
            token.approve(address(auction), tokenIdT);
        }

        function test_startAuction() public{
            //auction.startAuction(duringT, startingPriceT, tokenIdT, address(token)); 
            auction.startAuction(duringT, startingPriceT, tokenIdT); 
            assertEq(auction.startingPrice(), startingPriceT);
            assertEq(auction.during(), duringT);
            assertEq(auction.tokenId(), tokenIdT);
            assertEq(auction.isStart(), true);
            assertEq(auction.highestBidderAddress(), address(0));
            assertEq(auction.highestBid(), startingPriceT);
            assertEq(token.ownerOf(tokenIdT), address(auction));
        }

        function testAddBidd() internal{
            auction.startAuction(duringT, startingPriceT, tokenIdT); 
            console.log(auction.isStart());

        }

        // function testRemoveBidd() public payable{

        // }

        // function testEndAction() public{

        // } 
    }