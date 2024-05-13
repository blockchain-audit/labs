// pragma solidity ^0.8.24;

// import "forge-std/Test.sol";
// import "forge-std/console.sol";
// import "../../lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";
// import "@hack/auction/auction.sol";
// import "@hack/tokens/token3.sol";

// contract auctionTest is Test{
//     Token3 public token;
//     Auction public auction;
//     address adr1=address(1);

//     function setUp() public{
//     token = new Token3();
//     auction = new Auction();
//     console.log(msg.sender);
//     console.log(address(this));
//     //token.mint(address(this), 10000000);
//     token.mint(adr1, 111);
//     // token.mint(address(this), 10000000);
//     }

//     function testStartAuction() public{
//         vm.startPrank(adr1);
//         vm.warp(1);
//         auction.startAuction(111, 7*20*60*60);
//         // console.log(token.ownerOf(10000000));
//         // auction.startAuction(10000000,222235);

//     }




     

// }