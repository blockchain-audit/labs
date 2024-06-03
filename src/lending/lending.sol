// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.24;

import "@hack/staking/myToken.sol";
import "chain-link/src/v0.8/interfaces/AggregatorV3Interface.sol";

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
    uint public totalCollateral;
    mapping (address => uint) public usersCollaterals;
    mapping (address => uint) public usersBorrowed;

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

    function getBorrowRatio(uint amountEth, uint amountDai) public view returns (int) {
        (
            /* uint80 roundID */,
            int answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        return answer * int(amountEth  / amountDai);
    }


    function getBorrowRatio(uint _dai) public returns (uint) {
                (
            , // uint80 roundID
            int price,
            , // uint startedAt
            , // uint timeStamp
            // uint80 answeredInRound
        ) = priceFeed.latestRoundData();
        return price;
        // return price * msg.value / _dai;
    }

    function addCollateral() external payable {
        require(getBorrowRatio(amountDai) > minRatio, "you cant borrow this value, the ratio of your borrow is less that the min");
        usersCollaterals[msg.sender] += msg.value;
        totalCollateral += msg.value;

    }
 
    function discharge(address user) external {
        require(msg.sender == owner, "only owner can discharge eth");

        require(borrowers[user].eth / borrowers[user].dai <= minRatio);

    }
}