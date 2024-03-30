// SPDX-License-Identifier: Unlicense
pragma solidity >=0.5.11;

import "forge-std/Test.sol";
import "forge-std/console.sol";


//problem eve can to take from accounr alice tokens
contract ContractTest is Test {
    ERC20 ERC20Contract;
    address alice = vm. addr(1);
    address eve = vm.addr(2);

    function testApproveScan() public {
        ERC20Contract = new ERC20();
        ERC20Contract.mint(1000);
        ERC20Contract.transfer(address(alice), 1000);

        vm.prank(alice);
        ERC20Contract.approve(address(eve), type(uint256).max);

        console.log(
            "Before exploiting, Balance of Eve",
            ERC20Contract.balanceOf(eve)
        );

        console.log("Due to Alice granded transfer permission to Eve, now Eve can move funds from Alice");

        vm.prank(eve);
        ERC20Contract.tranferFrom(address(alice), address(eve),1000);
        console.log(
            "After exploiting, Balance of Eve",
            ERC20Contract.balanceOf(eve)
        );
        console.log("Exploint completed");
    }
    receive() external payable {}
}

interface IERC20{

    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amout) external returns (bool);

    //?
    function allowance(
        address owner,
        address spender 
    ) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function tranferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint amount);

}
contract ERC20 is IERC20 {
    uint public totalSupply;
    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;
    string public name =  "Test example";
    string public symbol = "Tast";
    uint public decimals = 18;

    function transfer(address recipient, uint amount) external returns (bool){
        balanceOf[msg.sender] -= amount;
        balanceOf[receipent] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    // allowing to spender spend from sender amount tokens
    function approve(address spender, uint amount) external returns (bool){
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender,amount);
        return true;
    }
    function transferFrom(
        address sender,
        address recipient,
        uint amount
    )
    external returns (bool) {
        allowance[sender][msg.sender] -= amount;
        balanceOf(sender) -= amount;
        balanceOf(recipient) += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    // anyone can do this function?
    function mint(uint amount) external{
        balanceOf(msg.sender) += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}
