// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/ERC20/ERC20.sol";

import "@openzeppelin/ERC20/IERC20.sol";

import "@hack/myTokens/myToken.sol";
//import "";
import "forge-std/console.sol";

import "@hack/math/mathLend.sol";

import "@hack/math/math.sol";


 interface ILendingPool {
    function deposit(
        address asset,
        uint256 amount,
        address onBehalfOf,
        uint16 referralCode
    ) external;

    function withdraw(
        address asset,
        uint256 amount,
        address to
    ) external returns (uint256);
}

contract Lend is Mathematics, DSMath{
    //using DSMath for uint256;
    address public owner;

    mapping(address=>uint) public userBorrowed;
    mapping(address=>uint) public userCollateral;
    //mapping(address=>uint) public depositDAI;


    IERC20 public dai;
    MyToken public bond;

    uint256 public totalBorrowed;
    uint256 public totalReserve;
    uint256 public totalDeposit;
    uint256 public maxLTV = 4; // 1 = 20%
    uint256 public ethTreasury;
    uint256 public totalCollateral;
    uint256 public baseRate = 20000000000000000;
    uint256 public fixedAnnuBorrowRate = 300000000000000000;

    ILendingPool public constant aave = ILendingPool(0xFf795577d9AC8bD7D90Ee22b6C1703490b6512FD);

    constructor(address _dai){
       dai = IERC20(_dai);
    }

    modifier amountPositive(uint amount){
        require(amount > 0, "Must be bigger than zero");
        _;
    }

    function bondAsset(uint _amount) external amountPositive(_amount){
        dai.transferFrom(msg.sender,address(this), _amount);
        totalDeposit += _amount;
        _sendDaiToAave(_amount);
        //uint bondsToMint = getExp(_amount, getExchangeRate());

    } 


     function _sendDaiToAave(uint256 _amount) internal {
        dai.approve(address(aave), _amount);
        aave.deposit(address(dai), _amount, address(this), 0);
    }

    // function getExchangeRate() public view returns (uint256) {
    //     if (totalSupply() == 0) {
    //         return 1000000000000000000;
    //     }
    //     uint256 cash = getCash();
    //     uint256 num = cash.add(totalBorrowed).add(totalReserve);
    //     return getExp(num, totalSupply());
    // }

}