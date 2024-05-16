// SPDX-License-Identifier: MIT
pragma solidity >=0.5.11;

import "openzeppelin-tokens/ERC721/ERC721.sol";
import "openzeppelin-tokens/ERC20/ERC20.sol";
import "forge-std/console.sol";

contract LendingProtocol {
    // DAI כתובת חוזה חכם של טוקן ה- 
    address public daiTokenAddress;
    
    // אג"ח
    mapping(address => uint256) public bondTokens;

    // כמה ETH הפקידו
    mapping(address => uint256) public collateral;

    uint256 constant MINIMUM_COLLATERAL = 1 ether;

    // תעריף הלוואה
    uint256 constant LOAN_INTEREST_RATE = 5; // 5%

    constructor(address _daiTokenAddress) {
        daiTokenAddress = _daiTokenAddress;
    }
    
    // Function for users to deposit DAI and receive bond tokens
    function deposit(uint256 daiAmount) external {
        // Transfer DAI tokens from user to this contract
        IERC20 daiToken = IERC20(daiTokenAddress);
        daiToken.transferFrom(msg.sender, address(this), daiAmount);
        
        uint256 received = daiAmount;
        
        bondTokens[msg.sender] += received;
    }
    
    // Function for users to unbond their bond tokens and receive DAI in return
    function withdraw(uint256 burn) external {
        // Ensure user has enough bond tokens
        require(bondTokens[msg.sender] >= burn, "Insufficient bond tokens");
        
        uint256 daiReturned = burn;
        
        IERC20 daiToken = IERC20(daiTokenAddress);
        daiToken.transfer(msg.sender, daiReturned);
        
        bondTokens[msg.sender] -= burn;
    }

    // Function for users to add ETH as collateral
    function addCollateral() external payable {
        // Ensure user sends at least 1 ETH
        require(msg.value >= MINIMUM_COLLATERAL, "Insufficient ETH sent");

        // Update collateral balance for the sender
        collateral[msg.sender] += msg.value;
    }

    // Function for users to remove their ETH collateral
    function removeCollateral(uint256 amount) external {
        // Ensure user has enough collateral
        require(collateral[msg.sender] >= amount, "Insufficient collateral");

        // Transfer ETH back to the user
        payable(msg.sender).transfer(amount);

        // Update collateral balance for the sender
        collateral[msg.sender] -= amount;
    }

    // Function for users to borrow assets using their deposited collateral
    function borrow(uint256 daiAmount) external {
        // Ensure user has enough collateral for the desired DAI amount
        require(collateral[msg.sender] >= daiAmount, "Insufficient collateral for borrowing");

        // Implement borrowing logic (not implemented yet)
    }

    // Function for users to repay borrowed assets and reduce their debt
    function repay(uint256 daiAmount) external {
        // Ensure user has enough borrowed DAI to repay
        require(bondTokens[msg.sender] >= daiAmount, "Insufficient borrowed DAI to repay");

        // Transfer DAI from user to this contract as repayment
        IERC20 daiToken = IERC20(daiTokenAddress);
        daiToken.transferFrom(msg.sender, address(this), daiAmount);

        // Reduce the user's debt (bond tokens)
        bondTokens[msg.sender] -= daiAmount;
    }

    // Function to trigger liquidation of user positions when their collateral value falls below a certain threshold
    function liquidate(address user) external {
        // Check if user's borrowed amount exceeds their collateral value beyond the specified maximum loan-to-value ratio
        // (not implemented yet)

        // Implement liquidation logic (not implemented yet)
    }

    // Function for the owner to harvest rewards accrued by the protocol
    function harvestRewards() external {
        // Implement reward harvesting logic (not implemented yet)
    }

    // Function for the owner to convert protocol treasury ETH to reserve assets
    function convertToReserve(address _reserveToken, uint256 _amount) external {
        // Implement treasury conversion logic (not implemented yet)
    }

    // Function to calculate the borrow limit
    function calculateBorrowLimit(uint256 collateralValue, uint256 borrowedValue, uint256 maxLTV) internal pure returns (uint256) {
        return (collateralValue - borrowedValue) * maxLTV / 100;
    }

    // Function to calculate the borrow fee
    function calculateBorrowFee(uint256 amount, uint256 borrowRate) internal pure returns (uint256) {
        return amount * borrowRate / 100;
    }
}
