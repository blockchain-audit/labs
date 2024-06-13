pragma solidity ^0.8.24;

import "forge-std/Test.sol";

contract testContract is Test{
    target targetContract;
    failedAttack faild;
    attack attackContract;
    targetRedim remidiate;

    constructor () {
        targetContract = new target();
        faild = new faildAttack();
        remidiate = new targetRedim();
    }

    function testFailedContractChack() public {
        console.log("before - the status of target" , targetContract.pwned());
        console.log("failed");
        faild.pwn(targetContract);
    }

    function testContractCheck() public {
        console.log("before - the status of target" , targetContract.pwned());
        attackContract = attack(targetContract);
        console.log("after - the status of target" , targetContract.pwned());
        console.log("done");
    }

    receive() external payable {}



}

contract target {
    function isContract(address account) public view returns (bool){
        uint size;
        assembly{
            size := extcodesize(account);
        }

        return size > 0;
    }

    bool public pwned = false;

    function protected() external {
        require(!isContract(msg.sender), "contract not alllowed");
        pwned = true;
    }


}

contract failedAttack is Test {
    function pwn(address Target) external {
        vm.expectRevert("no contract alllowed")ף
        target(Target).protected();
    }

}

contract attack {
    bool public isContract;
    address public addr;

    constructor(address Target){
        isContract = target(Target).isContract(address(this));
        addr = address(this);

        target(Target).protected();
    }
}
contract targetRedim{
    function isContract(address account) public view returns (bool) {
        require(tx.origin == msg.sender);
        return account.code.length > 0;
    }

    bool public pwned = false;

    function protected() external {
        require(!isContract(msg.sender), "contract not alllowed");
        pwned = true;
    }

}