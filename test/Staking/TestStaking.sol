pragma solidity 0.8.24;
//  import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "../../src/staking/staking.sol";
import "../../src/MyToken.sol";

contract TestStaking is Test {
    uint WAD = 10 ** 18;
    StakingRewards public stake;
    MyToken token;
    address public myUser = vm.addr(1234);

    function setUp() public {
        token = new MyToken();
        stake = new StakingRewards(address(token));
    }

    function TestDeposit() public {
        uint sum = 100 * WAD;
        token.mint(address(this), 1000);
        uint256 balanceBefore = stake.getBalance();
        token.approve(address(stake), sum);
        stake.deposit(sum);
        uint256 balanceAfterDeposit = stake.getBalance();
        assertEq(
            balanceBefore,
            balanceAfterDeposit,
            "The contract balance is not updated correctly"
        );
    }

    function TestWithdraw() public {
        console.log("test withdraw");
        uint256 sum = 100 * WAD;
        token.mint(address(this), sum);
        token.approve(address(stake), sum);
        stake.deposit(sum);
        vm.warp(block.timestamp + 7 days);
        uint256 firstBalance = stake.getBalance();
        stake.withdraw(sum);
        uint256 finalBalance = stake.getBalance(); //100
        console.log("The final User Balance", finalBalance);
        assertEq(firstBalance, finalBalance, "error");
    }

    function TestIsntWithdraw() public {
        uint256 sum = 200 * WAD;
        token.mint(address(this), sum);
        token.approve(address(stake), sum);
        stake.deposit(sum);
        uint256 balanceBefore = stake.getBalance();
        vm.expectRevert(); //Not a week has passed
        stake.withdraw(sum);
    }
}







