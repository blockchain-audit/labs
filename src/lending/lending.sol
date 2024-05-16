pragma solidity ^0.8.24;
import "forge-std/console.sol";
import "../../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "../../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "../../lib/openzeppelin-contracts/contracts/utils/math/Math.sol";
import "../math/Math.sol";
import "../math/Math.sol";

contract lending is ERC20, Math1 {
    using Math for uint256;
    

    uint256 public maxLTV;
    uint256 public totalDeposit;
    uint256 public totalBorrowed;
    uint256 public totalCollateral;
    uint256 public totalReserve;
    uint256 constant ethPrice = 2900;
    // mapping (address => uint256) usersDai;
    mapping (address => uint256) private usersCollateral;
    mapping (address => uint256) private usersBorrowed;
    IERC20 public dai ;

    constructor(address tokenDai) ERC20("bond token" ,"bt"){
        dai = IERC20(tokenDai);
    }

    receive() external payable{}

    
    modifier owner(){
       _; 
    }
    modifier user(){
        _;
    }


    function bond(uint256 amount) external user{
        require(amount > 0 );
        require(dai.balanceOf(msg.sender) >= amount, "you do not have enough ballance");
        dai.transferFrom(msg.sender , address(this), amount); 
        totalDeposit += amount;
       
        uint256 bondAmount = getExp(amount ,getExchangeRate() );
        _mint(msg.sender, bondAmount);
       
    }

    function unbond( uint256 amount) external user{
        require ( amount>0);
        require(balanceOf(msg.sender) >= amount, "you do not have enough tokens");
        dai.transferFrom(address(this), msg.sender, amount);
        uint256 daiToReceive = mulExp(amount ,getExchangeRate() );
        _burn(msg.sender, daiToReceive);
         totalDeposit -= amount;
        
    }
    function addCollateral() payable external user{
        require( msg.value > 0 );
        usersCollateral[msg.sender] += msg.value;
        totalCollateral += msg.value;
        
    }
    function removeCollateral( uint256 amount ) external user{
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
    function borrowDai( uint256 amount) external user{
        require ( usersCollateral[msg.sender] > 0,"you do not have any collaterals");
        uint256 barrowed = usersBorrowed[msg.sender];
        uint256 collateral = usersCollateral[msg.sender];

    }
    function repay() external user{
        
    }
    function trigger() external owner{
        
    }
    function harvest() external owner{
        
    }
    function convert() external owner{
        
    }


    function getExchangeRate() public view returns (uint256) {
        if (totalSupply() == 0) {
            return 1000000000000000000;
        }
        uint256 cash = totalDeposit - (totalBorrowed);
        uint256 num = cash + (totalBorrowed) + (totalReserve);
        return getExp(num, totalSupply());
    }


}