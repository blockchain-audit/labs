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
    token1 = new Token1();
    token2 = new Token2();
    cp = new CPAMM(address(token1),address(token2));
    token1.mint(msg.sender, 10000000);
    token1.mint(address(this), 10000000);
    token2.mint(address(this), 10000000);
    token2.mint(msg.sender, 10000000);
}

function testSwap() public {
    // set up
    testAddLiquidity3();
    token1.approve(address(cp),5);
    token2.approve(address(this),9);

    // use function
    cp.swap(address(token1),5);

    // check assertion
    

}
function testAddLiquidity () public{
    // set up
    uint reserve1 = cp.reserve0();
    uint reserve2 = cp.reserve1();
    token1.approve(address(cp),5);
    token2.approve(address(cp),10);

    // use function
    cp.addLiquidity(5 , 10);

    // check assertion
    uint newtotal = sqrt(5*10);
    assertEq (newtotal , cp.totalSupply());
    assertEq (reserve1 + 5 , cp.reserve0());
    assertEq (reserve2 + 10 , cp.reserve1());
}
function testAddLiquidity2 () public{
    // set up
    testAddLiquidity();
    uint total = cp.totalSupply();
    uint reserve1 = cp.reserve0();
    uint reserve2 = cp.reserve1();
    token1.approve(address(cp),15);
    token2.approve(address(cp),30);

    // use function
    cp.addLiquidity(15 , 30);

    // check assertion
    uint share = min((15 * total / reserve1) , (30 * total / reserve2));
    assertEq ((total+share),cp.totalSupply());
    assertEq (reserve1 + 15 , cp.reserve0());
    assertEq (reserve2 + 30 , cp.reserve1());
}
function testAddLiquidity3 () public{
    // set up
    testAddLiquidity2();
    uint total = cp.totalSupply();
    uint reserve1 = cp.reserve0();
    uint reserve2 = cp.reserve1();
    token1.approve(address(cp),1);
    token2.approve(address(cp),2);

    // use function
    cp.addLiquidity(1 , 2);

    // check assertion
    uint share = min((1*total/reserve1),(2*total/reserve2));
    assertEq ((total+share),cp.totalSupply());
    assertEq (reserve1 + 1 , cp.reserve0());
    assertEq (reserve2 + 2 , cp.reserve1());
}
function testRemoveLiquidity() public {

}
function sqrt(uint y) private pure returns (uint z ){
        if (y > 3){
            z = y;
            uint x = y / 2 + 1;
            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }
        }
        else if (y != 0){
            z = 1;
        }
    }
     function min (uint x, uint y) private pure returns (uint){
        return x <= y ? x : y;
    }


}
