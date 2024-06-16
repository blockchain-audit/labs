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
    uint256 constant wad = 10 ** 18;

    constructor(uint256 _minRatio) {
        owner = msg.sender;
        bonds = new MyToken();
        // Dai = IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);
        Dai = new MyToken();
        minRatio = _minRatio;
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
        uint256 countEth = borrowers[msg.sender].eth;
        uint256 countDai = borrowers[msg.sender].dai;
        Dai.transferFrom(msg.sender, address(this), countDai);
        payable(msg.sender).transfer(countEth);
    }

    function discharge(address to) public isOwner {
        require(borrowers[to].eth * getETHPrice() / wad < borrowers[msg.sender].dai * minRatio / wad);

        uint256 amountEth = borrowers[to].eth;
        uint256 valueEth = amountEth * getETHPrice() / wad;

        uint256 amountRatio = valueEth - borrowers[msg.sender].dai;
        uint256 amountRatioEth = amountRatio * wad / getETHPrice();

        uint256 amountFee = amountRatio / 2;
        uint256 amountFeeEth = amountFee * wad / getETHPrice();

        borrowers[to].eth = amountRatioEth - amountFeeEth;
        borrowers[msg.sender].dai = 0;

        swapEthToDai(amountEth - amountFeeEth);
    }

    function getETHPrice() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
        (, int256 price, , , ) =
            priceFeed.latestRoundData();
        return (uint256(price) * wad / 100000000);
    }

    function swapEthToDai(uint256 amountETH) private {
        //mock swap eth to dai
        uint256 amountDai = getETHPrice() * amountETH / wad;

        uint256 gas = amountDai * 995 / 1000;

        Dai.mint(amountDai - gas);

        payable(address(0)).transfer(amountETH);
    }
}
