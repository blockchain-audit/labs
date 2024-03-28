// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/wallet/wallet.sol";

contract WallerFuzzTest is Test{
    Wallet  public  wallet;

    function setUp() public {
        wallet =new Wallet();
        payable(address(wallet)).transfer(200);
    }

    function whiteDrawTest() public {
       address gabai = 0x29392969D235eA463A6AA42CFD4182ED2ecB5117;
       vm.startPrank(gabai);
       vm.deal(gabai , 1000);
       uint beforeWithDraw = address(gabai).balance;
       wallet.withdraw(100);
       assertEq(beforeWithDraw + 100, address(gabai).balance);
       console.log("beforeWithDraw    ", beforeWithDraw);
       console.log("after withDraw     ", address(gabai).balance);
       vm.stopPrank();

    }


}