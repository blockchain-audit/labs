pragma solidity ^0.8.24;
import "forge-std/Test.sol";
import "forge-std/console.sol";
// import "../../lib/openzeppelin-contracts/contracts/token/ERC720/IERC20.sol";
import "@hack/lending/lending.sol";
import "@hack/tokens/token2.sol";

contract lendingTest is Test {
    Token2 dai ;
    lending lend;

    function setUp() public{
        dai = new Token2();
        lend = new lending(address(dai));
        dai.mint(address(this) , 12345678);
        dai.mint(msg.sender , 2112234);
        console.log(address(this));
        console.log(msg.sender);
        console.log(address(lend));
    }
     function testBond() public {
        dai.approve(address(lend), 5555555555);
        dai.approve(msg.sender, 5555555555);
        lend.bond(11111);
        console.log(lend.balanceOf(address(this)));
        console.log(lend.balanceOf(msg.sender));
        console.log(lend.balanceOf(address(lend)));



     }


}