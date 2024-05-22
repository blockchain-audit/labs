// SPDX-License-Identifier: MIT
pragma solidity >=0.5.11;

import "@labs/tokens/MyToken.sol";
import "forge-std/interfaces/IERC20.sol";
import "../../../lib/chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import "forge-std/console.sol";

struct countETHandDai {
    uint256 eth;
    uint256 dai;
}

contract Lending {
    address owner;
    mapping(address => uint256) deposites;
    mapping(address => countETHandDai) borrowers;
    MyToken bonds;
    // IERC20 Dai;
    MyToken Dai;
    uint256 minRatio;
    uint constant wad = 10 ** 18;

    constructor(address bondsToken, uint256 _minRatio) public {
        owner = msg.sender;
        bonds = new MyToken();
        // Dai = IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);
        Dai = new MyToken();
        minRatio = minRatio;
    }

    modifier isOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }

    function deposit(uint256 countDai) public {
        deposites[msg.sender] = countDai;
        bonds.mint(msg.sender, countDai);
    }

    function withdrawDai(uint256 countBonds) public {
        require(bonds.balanceOf(msg.sender) >= countBonds, "Not enough bonds");
        bonds.burn(msg.sender, countBonds);
        Dai.transfer(msg.sender, countBonds);
    }

    function borrow(uint256 guaranteeRatio) public payable {
        require(guaranteeRatio >= minRatio, "the guarantee ratio small");
        uint256 valueEth = msg.value * getETHPrice() / wad;
        uint256 countDai = valueEth * wad / guaranteeRatio;
        require(Dai.balanceOf(address(this)) >= countDai, "There is not enough dai in the pool");
        borrowers[msg.sender] = countETHandDai(msg.value, countDai);
        Dai.transfer(msg.sender, countDai);
    }

    function returnBorrow() public {
        uint countEth = borrowers[msg.sender].eth;
        uint countDai = borrowers[msg.sender].dai;
        Dai.transferFrom(msg.sender, address(this), countDai);
        payable(msg.sender).transfer(countEth);
    }

    function discharge(address to) public isOwner {
        require(borrowers[to].eth * getETHPrice() / wad < borrowers[msg.sender].dai * minRatio / wad);

        uint amountEth = borrowers[to].eth;
        uint valueEth = amountEth * getETHPrice() / wad;

        uint amountRatio = valueEth - borrowers[msg.sender].dai;
        uint amountRatioEth = amountRatio * wad /getETHPrice();

        uint amountFee = amountRatio / 2;
        uint amountFeeEth = amountFee * wad / getETHPrice();

        borrowers[to].eth = amountRatioEth - amountFeeEth;
        borrowers[msg.sender].dai = 0;

        swapEthToDai(amountEth - amountFeeEth);
        
    }

    function getETHPrice() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
        (uint80 roundID, int256 price, uint256 startedAt, uint256 timeStamp, uint80 answeredInRound) =
            priceFeed.latestRoundData();
        return (uint(price) * wad / 100000000) ;
    }


    function swapEthToDai(uint amountETH)private{
        uint amountDai = getETHPrice() * amountETH / wad ;

        uint gas = amountDai * 995 / 1000;

        Dai.mint(amountDai - gas);

        payable(address(0)).transfer(amountETH);
    }
}
