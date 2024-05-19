pragma solidity ^0.8.24;

// import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "forge-std/console.sol";
// /home/user/Documents/yehudis/labs/lib/chainlink/contracts/src/v0.8/
import "../../lib/chainlink/contracts/src/v0.8/l2ep/dev/arbitrum/ArbitrumSequencerUptimeFeed.sol";
import "../../lib/chainlink/contracts/src/v0.8/interfaces/FeedRegistryInterface.sol";
import "../../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "../../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "../../lib/openzeppelin-contracts/contracts/utils/math/Math.sol";
import "../math/Math.sol";
import "../math/Math.sol";
import "../interfaces/ISwapRouter.sol";

contract lending is ERC20, Math1 {
    using Math for uint256;
    
    ArbitrumSequencerUptimeFeed internal priceFeed;
    uint256 public maxLTV = 4;
    uint256 public totalDeposit;
    uint256 public totalBorrowed;
    uint256 public totalCollateral;
    uint256 public totalReserve;
    uint256 constant ethPrice = 2900;
    uint256 public baseRate = 20000000000000000;
    uint256 public borrowRate = 300000000000000000;
    // mapping (address => uint256) usersDai;
    mapping (address => uint256) private usersCollateral;
    mapping (address => uint256) private usersBorrowed;

    // address public owner;
    IERC20 public dai ;

    constructor(address tokenDai) ERC20("bond token" ,"bt"){
        dai = IERC20(tokenDai);
        priceFeed = ArbitrumSequencerUptimeFeed(tokenDai);
        // owner = msg.sender;
        
    }

    receive() external payable{}

    
    modifier onlyOwner(){
       _; 
    }
    modifier onlyUser(){
        _;
    }


    function bond(uint256 amount) external onlyUser{
        require(amount > 0 );
        require(dai.balanceOf(msg.sender) >= amount, "you do not have enough ballance");
        dai.transferFrom(msg.sender , address(this), amount); 
        totalDeposit += amount;
       
        uint256 bondAmount = getExp(amount ,getExchangeRate() );
        _mint(msg.sender, bondAmount);
       
    }

    function unbond( uint256 amount) external onlyUser{
        require ( amount>0);
        require(balanceOf(msg.sender) >= amount, "you do not have enough tokens");
        dai.transferFrom(address(this), msg.sender, amount);
        uint256 daiToReceive = mulExp(amount ,getExchangeRate() );
        _burn(msg.sender, daiToReceive);
        totalDeposit -= amount;
        
    }
    function addCollateral() payable external onlyUser{
        require( msg.value > 0 );
        usersCollateral[msg.sender] += msg.value;
        totalCollateral += msg.value;
        
    }
    function removeCollateral( uint256 amount ) external onlyUser{
        require( amount > 0 );
        require ( usersCollateral[msg.sender] > 0,"you do not have any collaterals");
        uint256 barrowed = usersBorrowed[msg.sender];
        uint256 collateral = usersCollateral[msg.sender];
        uint256 left = mulExp(collateral, ethPrice) - barrowed;
        uint256 toRemove = mulExp(amount, ethPrice);
        require ( toRemove < left , "you do not have enough" );
        usersCollateral[msg.sender] -= amount;
        totalCollateral -= amount;
        payable(msg.sender).transfer(amount);

    }
    function borrowDai( uint256 amount) external onlyUser{
        require ( usersCollateral[msg.sender] > 0,"you do not have any collaterals");
        uint256 barrowed = usersBorrowed[msg.sender];
        uint256 collateral = usersCollateral[msg.sender];
        uint256 left = mulExp(collateral, ethPrice) - barrowed;
        uint256 borrowLimit = percentage(left, maxLTV);
        require ( borrowLimit >= amount , "you cannot pass the limit");
        dai.transferFrom(address(this) ,msg.sender, amount);
        totalBorrowed += amount;baseRate;

    }
    function repay( uint256 amount) external onlyUser{
        require (usersBorrowed[msg.sender] > 0 , "you do not have any dept");
        uint256 ratio = getExp(totalBorrowed, totalDeposit);
        uint256 interestMul = getExp(borrowRate - baseRate , ratio);
        uint256 rate = mulExp(ratio , interestMul) + baseRate;
        uint256 fee = amount * rate;
        uint256 paid = amount - fee;
        totalReserve += fee;
        usersBorrowed[msg.sender] -= paid;
        totalBorrowed -= paid;
    }
    function triggerLiquidation( address user ) external onlyOwner
    {
        uint256 barrowed = usersBorrowed[msg.sender];
        uint256 collateral = usersCollateral[msg.sender];
        uint256 left = mulExp(collateral, ethPrice) - barrowed;

          percentage(left, maxLTV);

    }
    function harvest() external onlyOwner{
        
    }
    function convert() external onlyOwner{
        
    }


    function getExchangeRate() public view returns (uint256) {
        if (totalSupply() == 0) {
            return 1000000000000000000;
        }
        uint256 cash = totalDeposit - (totalBorrowed);
        uint256 num = cash + (totalBorrowed) + (totalReserve);
        return getExp(num, totalSupply());
    }
      function _getLatestPrice() public view returns (int256) {
        (, int256 price, , , ) = priceFeed.latestRoundData();
        return price * 10**10;
    }


}