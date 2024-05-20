// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import "openzeppelin-tokens/ERC721/ERC721.sol";
import "openzeppelin-tokens/ERC20/ERC20.sol";
import "forge-std/console.sol";

interface IaWETH is IERC20 {
    function withdraw(uint256 amount) external;
}

interface IDex {
    function swapETHForDAI(uint256 ethAmount, address recipient) external payable returns (uint256);
}

contract LendingProtocol {
    // DAI כתובת חוזה חכם של טוקן ה-
    address public daiTokenAddress;
    address public owner; // Owner address

    // אג"ח
    mapping(address => uint256) public bondTokens;

    // כמה ETH הפקידו
    mapping(address => uint256) public collateral;

    uint256 constant MINIMUM_COLLATERAL = 1 ether;

    // תעריף הלוואה
    uint256 constant LOAN_INTEREST_RATE = 5; // 5%

    uint256 constant MAX_LTV_PERCENT = 70; // המגבלה כחלק מאה הכוללת

    uint256 public baseRate;
    uint256 public interestMultiplier;

    uint256 public totalDeposited; // סך כל ההפקדות
    uint256 public totalBorrowed; // סך כל ההשאלות

    uint256 totalETH;

    IERC20 daiToken;
    IaWETH public aWETHToken; // aWETH token address
    IDex public dex; // DEX contract address

    constructor(
        address _daiTokenAddress,
        address _aWETHTokenAddress,
        address _dexAddress,
        uint256 _baseRate,
        uint256 _interestMultiplier
    ) {
        owner = msg.sender; // Set the contract deployer as the owner
        baseRate = _baseRate;
        interestMultiplier = _interestMultiplier;
        daiToken = IERC20(_daiTokenAddress);
        aWETHToken = IaWETH(_aWETHTokenAddress);
        dex = IDex(_dexAddress);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    //1

    // Function for users to deposit DAI and receive bond tokens
    function deposit(uint256 daiAmount) external {
        // Transfer DAI tokens from user to this contract
        daiToken.transferFrom(msg.sender, address(this), daiAmount);

        bondTokens[msg.sender] += daiAmount;
        totalDeposited += daiAmount; // עדכון סכום ההפקדות
    }

    //2

    // Function for users to unbond their bond tokens and receive DAI in return
    function withdraw(uint256 burn) external {
        //burn - לשרוף
        // Ensure user has enough bond tokens
        require(bondTokens[msg.sender] >= burn, "Insufficient bond tokens");

        daiToken.transfer(msg.sender, burn);

        bondTokens[msg.sender] -= burn;
    }

    //3

    // Function for users to add ETH collateral
    function addCollateral() external payable {
        collateral[msg.sender] += msg.value;
        totalETH += msg.value;
    }

    //4

    // Function for users to remove their ETH collateral
    function removeCollateral(uint256 amount) external {
        // Ensure user has enough collateral
        require(collateral[msg.sender] >= amount, "Insufficient collateral");

        // Check if user has any open loans
        if (bondTokens[msg.sender] > 0) {
            // If user has open loans, repay them first
            repay(bondTokens[msg.sender]);
        }
        // Transfer ETH back to the user
        payable(msg.sender).transfer(amount);

        // Update collateral balance for the sender
        collateral[msg.sender] -= amount;
    }

    //5

    // Function for users to borrow assets using their deposited collateral
    function borrow(uint256 daiAmount) external {
        // Ensure user has enough collateral for the desired DAI amount
        require(collateral[msg.sender] >= daiAmount, "Insufficient collateral for borrowing");

        require(daiToken.transfer(msg.sender, daiAmount), "DAI transfer failed");

        // Update user's borrowed amount (bond tokens)
        bondTokens[msg.sender] += daiAmount;

        // Update total borrowed amount
        totalBorrowed += daiAmount;
    }

    //6

    // Function for users to repay borrowed assets and reduce their debt
    function repay(uint256 daiAmount) public {
        // Ensure user has enough borrowed DAI to repay
        require(bondTokens[msg.sender] >= daiAmount, "Insufficient borrowed DAI to repay");

        // Calculate the borrowing fee - תַשְׁלוּם
        uint256 fee = calculateBorrowFee(daiAmount); //מחשבת את עמלת ההלוואה

        // Total amount to repay including the fee
        uint256 totalRepayment = daiAmount + fee;

        // Ensure the user has enough DAI to repay including the fee
        require(daiToken.balanceOf(msg.sender) >= totalRepayment, "Insufficient DAI to repay");

        // Transfer DAI from user to this contract as repayment
        daiToken.transferFrom(msg.sender, address(this), totalRepayment);

        // Reduce the user's debt (bond tokens)
        bondTokens[msg.sender] -= daiAmount;

        // Update total borrowed amount
        totalBorrowed -= daiAmount;
    }

    // Function to calculate the borrow fee
    function calculateBorrowFee(uint256 amount) internal view returns (uint256) {
        uint256 utilizationRatio = (totalBorrowed * 1e18) / totalDeposited;
        uint256 borrowRate = (utilizationRatio * interestMultiplier) / 1e18 + baseRate;
        return (amount * borrowRate) / 1e18;
    }

    //7

    // Function to get the collateral value in DAI
    function getCollateralValueInDAI(address user) public view returns (uint256) {
        uint256 ethPriceInDAI = getETHPriceInDAI();
        return (collateral[user] * ethPriceInDAI) / 1 ether;
    }

    // Mock function to get the ETH price in DAI, this should ideally be fetched from an oracle
    function getETHPriceInDAI() public view returns (uint256) {
        return 2000; // Example value, replace with actual oracle call
    }

    // Function to liquidate user's position if their collateral value falls below the threshold
    function liquidate(address user) external onlyOwner {
        uint256 collateralValue = getCollateralValueInDAI(user);
        uint256 borrowedValue = bondTokens[user];

        uint256 liquidationThreshold = (collateralValue * MAX_LTV_PERCENT) / 100;
        require(borrowedValue > liquidationThreshold, "Collateral value is sufficient, cannot liquidate");

        // Transfer collateral to owner
        uint256 collateralToTransfer = collateral[user];
        totalETH -= collateralToTransfer;
        collateral[user] = 0;

        // Transfer borrowed DAI to owner
        daiToken.transfer(owner, borrowedValue);

        // Clear user's debt
        bondTokens[user] = 0;
    }

    //8

    // Function for the owner to harvest rewards accrued by the protocol in the form of aWETH and convert them to ETH
    function harvestRewards() external onlyOwner {
        uint256 aWETHBalance = aWETHToken.balanceOf(address(this));
        require(aWETHBalance > 0, "No rewards to harvest");

        // Withdraw aWETH to get ETH
        aWETHToken.withdraw(aWETHBalance);

        // The contract now holds the withdrawn ETH
        uint256 harvestedETH = address(this).balance;

        // Transfer the harvested ETH to the owner
        payable(owner).transfer(harvestedETH);
    }

    //9

    // Function for the owner to convert protocol treasury ETH to reserve assets (DAI)
    function convertETHToReserve(uint256 ethAmount) external onlyOwner {
        require(address(this).balance >= ethAmount, "Insufficient ETH balance");

        // Swap ETH for DAI using the DEX
        uint256 daiReceived = dex.swapETHForDAI{value: ethAmount}(ethAmount, address(this));
        require(daiReceived > 0, "DEX swap failed");

        // Add the received DAI to the protocol's reserve
        totalDeposited += daiReceived;
    }

    // Receive function to accept ETH
    receive() external payable {}
}
