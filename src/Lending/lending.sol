// SPDX-License-Identifier: MIT
// https://solidity-by-example.org/defi/staking-rewards/
// Code is a stripped down version of Synthetix

pragma solidity ^0.8.24;

// import "@hack/libs/ierc20.sol";
import "../MyToken/MyToken.sol";

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
        uint256 amountBondToken;
    }

    IERC20 public daiToken; // transfer to the contract from depositor in deposit
    mapping(address => Borrower) public borrowers;
    mapping(address => Depositor) public depositors;
    uint256 public totalDeposit; //sum of dai in the pool
    uint256 public totalRewards; //sum of reward - fees
    uint256 feePercent; //percent of reward from borrower
    uint256 WAD = 10 ** 18;
    uint256 public collateralRatio;
    address public owner;
    MyToken public bondToken;

    constructor() {
        feePercent = (3 * 997) * WAD / 1000; // 0.03
        totalDeposit = 0;
        totalRewards = 0;
        collateralRatio = 15 * WAD / 10; // 1.5
        owner = msg.sender;
        daiToken = IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F); // address-DAI
        bondToken = new MyToken();
    }

    receive() external payable {}

    function getPrice(address token) public view returns (uint256 amount) {
        require(token == address(daiToken) || token == 0x2a1530C4C41db0B0b2bB646CB5Eb1A67b7158667, "invalid-token"); // DAI or ETH
        amount = token == address(daiToken) ? 3000 : 1;
    }

    function deposit(uint256 _amount) external {
        // how to make sure that is DAI? check in test
        // user deposit DAI and get bondToken
        require(_amount > 0, "Amount less than 0");
        require(depositors[msg.sender].amount == 0, /*|| depositors[msg.sender] == null*/ "deposit only when empty");
        daiToken.transferFrom(msg.sender, address(this), _amount);
        totalDeposit += _amount;
        bondToken.mint(_amount);
        bondToken.approve(msg.sender, _amount);
        bondToken.transfer(msg.sender, _amount);
        Depositor memory d = Depositor({
            amount: _amount,
            depositDate: block.timestamp,
            currentTotalFee: totalRewards,
            amountBondToken: _amount
        });
        depositors[msg.sender] = d;
    }

    function addCollaterals() public payable {
        // user can add collaterals (ETH)
        // if(borrower[msg.sender]==null){
        //     Borrower memory b =
        //     Borrower({collateralValue: msg.value, borrowedValue: 0 , borrowDate: 0});
        //     borrowers[msg.sender] = b;
        // } else {}
        borrowers[msg.sender].collateralValue += msg.value;
        payable(address(this)).transfer(msg.sender, msg.value); // transfer collaterals from user to the contract
    }

    function removeCollaterals() public payable {
        // user can remove collaterals (ETH)
        require(
            borrowers[msg.sender].collateralValue >= msg.value
                && borrowers[msg.sender].collateralValue - msg.value * collateralRatio
                    >= borrowers[msg.sender].borrowedValue,
            "not enough collateral to remove"
        ); // check if there is enough collateral to user
        borrowers[msg.sender].collateralValue -= msg.value;
        payable(msg.sender).transfer(address(this), msg.value); // transfer collaterals from contract to the user
    }

    function borrow(uint256 borrowAmount) external payable {
        // receive borrowAmount (DAI)
        require(borrowAmount * collateralRatio <= borrowers[msg.sender].collateralValue, "not enough collaterals");
        require(borrowAmount < totalDeposit, "not enough money to borrow");
        borrowers[msg.sender].borrowDate = block.timestamp();
        borrowers[msg.sender].borrowedValue += borrowAmount;
        daiToken.transfer(msg.sender, borrowAmount);
        totalDeposit -= borrowAmount;
    }

    function withdraw(uint256 _amount) public {
        // user withDraw the amount with amount BondToken
        require(_amount >= depositors[msg.sender].amountBondToken, "not enough amountBondToken");
        depositors[msg.sender].amount -= _amount;
        depositors[msg.sender].amountBondToken -= _amount;
        bondToken.burn(_amount);
        uint256 reward = (totalRewards - depositors[msg.sender].currentTotalFee)
            * (block.timestamp - depositors[msg.sender].depositDate) * feePercent;
        totalDeposit -= _amount;
        totalRewards -= reward;

        daiToken.transfer(msg.sender, _amount + reward);
    }

    function calculateFee(uint256 amount) public view returns (uint256 fee) {
        require(borrowers[msg.sender].borrowedValue >= amount, "amount big from your borrow");
        fee = amount * feePercent * (block.timestamp - borrowers[msg.sender].borrowDate);
    }

    function loanRepayment(uint256 _amount) public returns (uint256 fee) {
        //user return DAI and receive the colletorals
        require(borrowers[msg.sender].borrowedValue > 0, "not borrow");
        require(
            _amount - borrowers[msg.sender].borrowedValue == calculateFee(_amount),
            "not enough fee" + calculateFee(_amount)
        );
        daiToken.transferFrom(msg.sender, address(this), _amount); //return borrow + fee
        totalRewards += _amount - borrowers[msg.sender].borrowedValue;
        borrowers[msg.sender].borrowedValue -= _amount;
        totalDeposit += _amount - borrowers[msg.sender].borrowedValue;
        //return collaterals
    }
}