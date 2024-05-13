//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/auction/ww.sol";
import "../../lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";
import "@hack/auction/mytoken.sol";
contract testAuctions is Test {
    Auctions a;
    MyToken token;
    address adr1=address(1);
    function setUp() public{
        a = new Auctions();
        token = new MyToken();
        token.mint(adr1, 111);
    }
    function testStartAuction() public {
        vm.startPrank(adr1);
        vm.warp(1);
        a.startAuction(111, 7*20*60*60);
        address[] memory aa;
        // assertEq(a.auctions[111],{
        //     adr1,
        //     true,
        //     false,
        //     block.timestamp + 7*24*60*60,
        //     0,
        //     address(0),
        //     111,
        //     aa
        // });
    }
}