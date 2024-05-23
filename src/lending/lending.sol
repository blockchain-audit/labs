// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

import "@hack/staking/myToken.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

struct Borrow 
{
    uint eth;
    uint dai;
}
contract Lending {

    AggregatorV3Interface internal priceFeed;
    MyToken public bond;
    MyToken public dai;
    address public owner;
    uint public minRatio = 110000000;
    mapping (address => uint) public depositers;
    mapping (address => Borrow) public borrowers;

    constructor (address _dai, address _bond) {
        owner = msg.sender;
        bond = MyToken(_bond);
        dai = MyToken(_dai);
        priceFeed = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
    }

    function depositDai(uint amountDai) public { 
        dai.transferFrom(msg.sender, address(this), amountDai);
        bond.mint(msg.sender, amountDai);
        depositers[msg.sender] = amountDai;
    }

    function withdrawDai(uint amountDai) public {
        require(depositers[msg.sender] >= amountDai, "You dont have enough Dai in the protocol");
        dai.transfer(msg.sender, amountDai);
        bond.transferFrom(msg.sender, address(this), amountDai);
    }

    function addBorrow(uint amountDai) external payable {
        require(getBorrowRatio(msg.value, amountDai) > minRatio, "you cant borrow this value, the ratio of your borrow is less that the min");
        borrowers[msg.sender].eth += msg.value;


        borrowers[msg.sender].dai += amountDai;
    }

    function getBorrowRatio(uint eth, uint dai) external returns (uint) {
        int price = priceFeed.latestRoundData();
        return price * eth  / dai;
    }

    function discharge(address user) external {
        require(msg.sender == owner, "only owner can discharge eth");

        require(borrowers[user].eth / borrowers[user].dai <= minRatio);

    }



}