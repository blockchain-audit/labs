// // SPDX-License-Identifier: MIT
// pragma solidity >=0.5.11;

// import "@labs/tokens/MyToken.sol";
// import "forge-std/interfaces/IERC20.sol";
// import "../../../lib/chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

// struct countETHandDai {
//     uint256 eth;
//     uint256 dai;
// }

// contract Lending {
//     address owner;
//     mapping(address => uint256) deposites;
//     mapping(address => countETHandDai) borrowers;
//     MyToken bonds;
//     IERC20 Dai;
//     uint256 minRatio;

//     constructor(address bondsToken, uint256 _minRatio) public {
//         owner = msg.sender;
//         bonds = new MyToken();
//         // Dai = IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);
//         Dai = new MyToken();
//         minRatio = minRatio;
//     }

//     modifier isOwner() {
//         require(msg.sender == owner, "not owner");
//         _;
//     }

//     function deposit(uint256 countDai) public {
//         deposites[msg.sender] = countDai;
//         bonds.mint(msg.sender, countDai);
//     }

//     function withdrawDai(uint256 countBonds) public {
//         require(bonds.balanceOf(msg.sender) >= countBonds, "Not enough bonds");
//         bonds.burn(msg.sender, countBonds);
//         Dai.transfer(msg.sender, countBonds);
//     }

//     function borrow(uint256 guaranteeRatio) public payable {
//         require(guaranteeRatio >= minRatio, "the guarantee ratio small");
//         uint256 valueEth = msg.value * getETHPrice() / wad;
//         uint256 countDai = valueEth * wad / guaranteeRatio;
//         require(Dai.balanceOf(address(this)) >= countDai, "There is not enough dai in the pool");
//         borrowers[msg.sender] = countETHandDai(msg.value, countDai);
//         Dai.transfer(msg.sender, countDai);
//     }

//     function returnBorrow() public {
//         countEth = borrowers[msg.sender].eth;
//         countDai = borrowers[msg.sender].dai;
//         Dai.transferFrom(msg.sender, address(this), countDai);
//         payable(msg.sender).transfer(countEth);
//     }

//     function discharge(address to) public isOwner {
//         require(borrowers[to].eth * getETHPrice() / wad < borrowers[msg.sender].dai * minRatio / wad);
        
//     }

//     function getETHPrice() public view returns (int256) {
//         AggregatorV3Interface priceFeed = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
//         (uint80 roundID, int256 price, uint256 startedAt, uint256 timeStamp, uint80 answeredInRound) =
//             priceFeed.latestRoundData();
//         //  (, int price, , , ) = priceFeed.latestRoundData();
//         return price;
//     }


//     function swapEthToDai()private{
        
//     }
// }
