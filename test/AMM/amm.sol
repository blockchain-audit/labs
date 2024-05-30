pragma solidity ^0.8.20;
//  import "foundry-huff/HuffDeployer.sol";
 import "forge-std/Test.sol";
//  import "@hack/store/store.sol";
 import "../../../src/AMM/amm.sol";
 contract TestAMM is Test{
   amm public a;
   address public owner = vm.addr(1234);
     function setUp() public {
        a = new a();
     }

       function testChangeX() public {
        uint256 sum = 20;
        uint256 calc = a.changeX(sum);
        assertEq(calc,16.7,"error")
     }
      function testChangeY() public {
        
     }
 }