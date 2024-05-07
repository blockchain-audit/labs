pragma solidity ^0.8.24;


import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/amm/cpamm.sol";
import "@hack/tokens/token1.sol";
import "@hack/tokens/token2.sol";

contract cpammTest is Test{
    Token1 public token1;
    Token2 public token2;
    CPAMM public cp;

function setUp() public{
    cp = new CPAMM(address(token1),address(token2));
    token1.mint(msg.sender, 10000000);
    token2.mint(msg.sender, 10000000);
}

function testAddLiquidity () public{
    cp.addLiquidity(10 , 20);

}


}
