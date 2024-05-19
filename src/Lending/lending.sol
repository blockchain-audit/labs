// SPDX-License-Identifier: MIT
// https://solidity-by-example.org/defi/staking-rewards/
// Code is a stripped down version of Synthetix

pragma solidity ^0.8.24;

import "@hack/libs/ierc20.sol";

contract Lending {
    
    struct Borrower {
        uint256 collateralValue; //ETH 
        uint256 borrowedValue; //DAI
        uint256 borrowDate;
    }

    struct Depositor {
        uint256 amount;
        uint256 depositDate;
        uint256 currentTotalFee;
    }

    IERC20 public daiToken; // transfer to the contract from depositor in deposit
    mapping(address => Borrower) public borrowers;
    mapping(address => Depositor) public depositors;
    uint256 public totalDeposit; //sum of dai in the pool
    uint256 public totalRewards; //sum of reward - fees
    uint256 feePercent; //percent of reward from borrower
    uint256 WAD = 10 ** 18;
    uint256 public coletoralRatio;
    address public owner;

    constructor() {
        feePercent = (3 * 997) * WAD / 1000; // 0.03
        totalDeposit = 0;
        totalRewards = 0;
        coletoralRatio = 15 * WAD / 10; // 1.5
        owner = msg.sender;
    }

    receive() external payable {}

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    function deposit(uint256 _amount) external {
        require(_amount > 0, "Amount less than 0");
        totalDeposit += _amount;
        // Depositor memory d = new Depositor({amount: _amount, depositDate: block.timestamp, currentTotalFee: totalRewards});
        Depositor memory d;
        d.amount = _amount;
        d.depositDate = block.timestamp;
        d.currentTotalFee = totalRewards;
        depositors[msg.sender] = d;
        daiToken.transferFrom(msg.sender, address(this), _amount);
    }

    function borrow(uint256 borrowAmount) public payable {
        // msg.value = coletorals (ETH)  // borrowAmount (DAI)
        require(borrowAmount * coletoralRatio <= msg.value, "not enough coletorals");
        require(borrowAmount < totalDeposit, "not enough money to borrow");
        Borrower memory b;
        b.collateralValue = msg.value;
        b.borrowedValue = borrowAmount;
        b.borrowDate = block.timestamp;
        borrowers[msg.sender] = b;
        daiToken.transfer(msg.sender, borrowAmount);
        totalDeposit -= borrowAmount;
    }

    function withdraw(uint256 _amount) public {
        require(_amount > 0, "Amount must be greater than 0");
        require(_amount <= depositors[msg.sender].amount, "Amount must be less than your deposit");
        depositors[msg.sender].amount -= _amount;
        uint256 reward = (totalRewards - depositors[msg.sender].currentTotalFee)
            * (block.timestamp - depositors[msg.sender].depositDate) * feePercent;

        totalDeposit -= _amount;
        totalRewards -= reward;

        daiToken.transfer(msg.sender, _amount + reward);
    }

    function calculateFee() public view returns (uint256 fee) {
        fee = borrowers[msg.sender].borrowedValue * feePercent * (block.timestamp - borrowers[msg.sender].borrowDate);
    }

    function loanRepayment(uint256 _amount) public {
        //return all borrowing
        require(_amount - borrowers[msg.sender].borrowedValue == calculateFee(), "not enough fee");
        daiToken.transferFrom(msg.sender, address(this), _amount); //return borrow + fee
        totalRewards += _amount - borrowers[msg.sender].borrowedValue;
        borrowers[msg.sender].borrowedValue = 0;
        totalDeposit += _amount - borrowers[msg.sender].borrowedValue;

        //return coletorals
    }
}
