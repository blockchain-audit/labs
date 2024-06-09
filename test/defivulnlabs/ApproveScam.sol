pragma solidity ^0.8.24;

contract contractTest {

    ERC20 ERC20contract ;
    address alice = vm.addr(1);
    address eve = vm.addr(2);

    function testApproveScam()  public {

        ERC20contract = new ERC20();
        ERC20contract.mint(1000);
        ERC20contract.transfer(address(alice), 100000);

        vm.prank(alice);
        ERC20contract.approve(address(eve), type(uint256).max);

        console.log("balance eve before" ERC20contract.balanceOf(eve));
        console.log("eve can move funds from alice due to the permission given");

        vm.prank(eve);

        ERC20contract.transferFrom(address(alice), address(eve), 100000);

        console.log("balance eve after" ERC20contract.balanceOf(eve));
        console.log("done")
        
    }

receive() external payable {}  
   
}

interface IERC20{
    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom (address sender, address recipient, uint amount) external returns (bool);

    event Transfer(address indexed from, address indexed to , uint amount);

    event Approval(address indexed owner, address indexed spender, uint amount);

}

contract ERC20 is IERC20 {
    uint public totalSupply;
    mapping ( (uint) => address) public balanceOf;
    mapping (address => mapping(address => uint)) public allowance;
    string public name = "Test examle";
    string public symbol = "test";
    uint8 public decimal = 18;

    function transfer(address recipient, uint amount) external returns (bool){
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint amount) external returns (bool){
        allowance[mag.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint amount) external returns (bool) {
        allowance[sender][recipient] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function mint(uint amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}


