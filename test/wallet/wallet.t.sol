 SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/wallet/wallet.sol";
// contract User {
//     Wallet public  w;
//     constructor (Wallet w_) {
//         w = w_;
//     }
//     function makeDeposit (uint wad) public {
//         w.receiveit();
//     }
// }

contract WalletTest is Test {
    Wallet public wallet1;
    function setUp() public {
      wallet1 = new Wallet();
      payable(address(wallet1)).transfer(100);
    }

    function testWithdrawWork() public {
    //    User user1 = new User();
    //    user1.makeDeposit(30);
//  payable(address(wallet1)).transfer(100);
//  console.log(address(wallet1).balance);
//        wallet1.withdraw(1);
       address address1=0x074AC318E0f004146dbf4D3CA59d00b96a100100;
       vm.startPrank(address1);
       vm.deal(address1 , 100);
       uint256 total = address(wallet1).balance;
       payable(address(wallet1)).transfer(100);
       uint256 after1 = address(wallet1).balance;
       assertEq(total+100,after1);
    //   console.log(address(wallet1).balance);
       wallet1.withdraw(50);
    //    console.log(address(wallet1).balance);
    //    console.log("wallet1", address(wallet1));
    //    console.log("address1", address(address1));
    //    console.log("balence",wallet1.getBalance());
       vm.stopPrank();
    }
//    function testWithdrawNotWorking() public {
//       address address1=0x138b601992D3E744cD2a883bF5a46b3a23D9E7F5;
//       vm.startPrank(address1);
//       vm.deal(address1 , 100);
//       uint256 total = address(wallet1).balance;
//       payable(address(wallet1)).transfer(100);
//       uint256 after1 = address(wallet1).balance;
//       assertEq(total+100,after1);
//       wallet1.withdraw(50);
//       console.log("balence",wallet1.getBalance());
//       vm.stopPrank();
//     }
    // function testInsert() public {
    //     address userAddress =0x29392969D235eA463A6AA42CFD4182ED2ecB5117;
    //     vm.startPrank(userAddress);
    //     vm.deal(userAddress, 100);
    //     uint256 beforeAdding = address(wallet1).balance;
    //     console.log("address(wallet1).balance;", address(wallet1).balance);
    //     console.log("address(userAddress).balance;", address(userAddress).balance);
    //     wallet1.insert(0x138b601992D3E744cD2a883bF5a46b3a23D9E7F5);
    //     vm.stopPrank();
    // }
    function testremove() public {
        address userAddress =0x29392969D235eA463A6AA42CFD4182ED2ecB5117;
        vm.startPrank(userAddress);
        vm.deal(userAddress, 100);
        uint256 beforeAdding = address(wallet1).balance;
        console.log("address(wallet1).balance;", address(wallet1).balance);
        console.log("address(userAddress).balance;", address(userAddress).balance);
        wallet1.remove(0x074AC318E0f004146dbf4D3CA59d00b96a100100);
        vm.stopPrank();
    }
        function testReplace() public {
        address userAddress =0x29392969D235eA463A6AA42CFD4182ED2ecB5117;
        vm.startPrank(userAddress);
        vm.deal(userAddress, 100);
        uint256 beforeAdding = address(wallet1).balance;
        console.log("address(wallet1).balance;", address(wallet1).balance);
        console.log("address(userAddress).balance;", address(userAddress).balance);
        wallet1.replace(0x074AC318E0f004146dbf4D3CA59d00b96a100100,0x138b601992D3E744cD2a883bF5a46b3a23D9E7F5);
        vm.stopPrank();
    }
}





