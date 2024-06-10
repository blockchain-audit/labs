// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "../../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "../../lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "../MyToken.sol";

contract Lending{
    MyToken public immutable Bond;
    MyToken public immutable Dai;
    mapping (address => uint256) borrowers;
    mapping (address => uint256) giving;
    mapping (address => uint256) deposition;
    mapping (address => uint256) depositTime;
    uint256 totalSuply;
    uint256 rate;
    address owner;
    uint256 immutable wad=1e18;

    constructor(address _myCoinNFT,address _myCoineE,uint256 _rate) {
       Bond = MyToken();
       Dai = MyToken(0x6B175474E89094C44Da98b954EedeAC495271d0F);
       owner = payable(msg.sender);
       rate=_rate/100;

}

function deposit(uint256 amount) external{
    require(depositTime[msg.sender]==0,"You have already an open account");
    require(amount>0,"The amount of Dai is not enougth");
    Dai.transferFrom(msg.sender,address(this),amount);
    Bond.mint(msg.sender,amount);
    deposition[msg.sender]=amount;
    depositTime[msg.sender]=block.timestamp;
}

function reward(uint256 amount,address user) private returns(uint256){
    uint256 sum=deposition[user]*rate*amount;
    uint256 week=60*60*24*7;
    uint256 duration=(block.timestamp-depositTime[msg.sender])/week;
    return sum*duration;

}

function withdrow(uint256 amount) external{
    require(amount>0,"The amount of Bond is not enougth");
    Bond.burn(msg.sender, amount);
    uint256 myReward=reward(amount,msg.sender);
    Dai.transferFrom(address(this),msg.sender,amount+myReward);

}


// function borrower (uint256 amount) external{
//     require(amount>0,"The amount of ETHERUM is not enougth")
    
// }



}