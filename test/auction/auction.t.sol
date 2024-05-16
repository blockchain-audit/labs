//   // SPDX-License-Identifier: Unlicen
// pragma solidity ^0.8.24;

// import "../../src/auction/auction.sol";
// import "openzeppelin-tokens/ERC721/ERC721.sol";
// import "openzeppelin-tokens/ERC20/ERC20.sol";
// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
// import "forge-std/Test.sol";
// import "forge-std/console.sol";
// import "@hack/store/store.sol";
// import "/home/user/myToken/new-project/script/myToken.sol";


// contract TestAuction is Test {

//     Auction auction;
//     address NFTtoken;
//     address token;
//     uint _NFTtokenId;
//     uint startPrice; 
//     uint duration;

//     ERC721 nftContract;
//     MyToken coin; 
//     function setUp() public {
//          _NFTtokenId = 1;     
//          nftContract = ERC721(NFTtoken);
//          startPrice = 10;
//          duration = 7;  
//          coin = new MyToken();    
//          auction = new Auction(address(nftContract), _NFTtokenId, address(coin), startPrice, duration);
//     } 

//      function testBid() public {

//          uint bidAmount = 15;
//          coin.mint(address(this), 30);
//          coin.approve(address(auction),30);

//          uint beforMaxPrice = auction.maxPrice();

//          auction.bid(bidAmount);

//          uint afterMaxPrice = auction.maxPrice();

//          if(beforMaxPrice != afterMaxPrice){
//             console.log("Max price should be updated after bidding");
//          }

//     }
//     function testNotBid() public {

//          uint bidAmount = 9;
//          coin.mint(address(this), 30);
//          coin.approve(address(auction),30);

//          uint beforMaxPrice = auction.maxPrice();

//          vm.expectRevert();
//          auction.bid(bidAmount);

//          uint afterMaxPrice = auction.maxPrice();

//          if(beforMaxPrice != afterMaxPrice){
//             console.log("Max price should be updated after bidding");
//         }

//     }
//      function testWinner() public {

//         uint bidAmount = 15;
//         coin.mint(address(this), 30);
//         coin.approve(address(auction),30);
//         auction.bid(bidAmount);
//         auction.winner();
//      }

// }