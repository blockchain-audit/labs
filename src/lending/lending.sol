pragma solidity ^0.8.24;
import "forge-std/console.sol";
import "../../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "../../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "../../lib/openzeppelin-contracts/contracts/utils/math/Math.sol";
import "../math/Math";

contract lending is ERC20{
    using Math for uint256;

    

    uint256 public maxLTV;
    uint256 public totalDeposit;
    mapping (address => uint256) users;
    IERC20 public dai ;

    constructor(address tokenDai) ERC20("bond" ,"bt"){
        dai = IERC20(tokenDai);
    }




    
    modifier owner(){
       _; 
    }
    modifier user(){
        _;
    }


    function deposite(uint256 amount) external user{
        require(amount > 0 );
        dai.transferFrom(msg.sender , address(this), amount);
        uint256 bondAmount = getExp(88,88);

        _mint(msg.sender, bondAmount);
        users[msg.sender] = amount;

    }

    function unbond() external user{
        
    }
    function add() external user{
        
    }
    function remove() external user{
        
    }
    function borrow() external user{
        
    }
    function repay() external user{
        
    }
    function trigger() external owner{
        
    }
    function harvest() external owner{
        
    }
    function convert() external owner{
        
    }


}