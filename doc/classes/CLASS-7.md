


```
curl -L https://foundry.paradigm.xyz | bash


curl -L get.huff.sh | bash
```


* [logic-rambam](../reference/rambam-logic.pdf)
* [sylogisms](../reference/silogisms.pdf)
* [audit-101](https://github.com/blockchain-audit/DeFiVulnLabs/tree/main)



We fixed the Hazan's code, added some money into the smart contract using the setup, and also checked who are the `msg.sender` in the different contexts.


```solidity

contract CollectorsTest is Test {
    CollectorsWallet public wallet;

    function setUp() public {
        wallet = new CollectorsWallet();
        payable(address(wallet)).transfer(50); // move 50 to the contract
    }

    function testReceive() public {
        // this is a deterministic
        address randomAddress = vm.addr(1234); // create random address
        uint256 amount = 100;
        vm.deal(randomAddress, amount); // put money in this wallet

        //vm.startPrank(randomAddress); // send from random address
        uint256 initialBalance = address(wallet).balance; // the balance in the begining (before transfer)
        console.log(initialBalance);
        uint256 finalBalance = address(wallet).balance; // the balance in the final (aftere transfer)
        assertEq(finalBalance, initialBalance + 100);

        //vm.stopPrank();
    }

    function testNotAllowedWd() external {
        uint256 withdrawAmount = 1;
        address userAddress = vm.addr(12); // address of not allowed user
        vm.startPrank(userAddress); // send from random address

        // uint256 initialBalance = uint256(address(wallet).balance); // the balance in the begining (before transfer)
        vm.expectRevert();
        wallet.withdraw(withdrawAmount);
        // uint256 finalBalance = uint256(address(walletC).balance); // the balance in the final (after transfer)
        // assertEq(finalBalance, initialBalance - withdrawAmount);
        vm.stopPrank();
    }

    function testAllowedWd() external {
        uint256 withdrawAmount = 50;
        address userAddress = 0x7a3b914a1f0bD991BAf826F4fE9a47Bb9880d25f; // address of allowed user
        vm.startPrank(userAddress); // send from random address

        console.log(address(userAddress).balance);
        //uint256 initialBalance = address(wallet).balance); // the balance in the begining (before transfer)
        //vm.expectRevert();
        wallet.withdraw(withdrawAmount);

        // uint256 finalBalance = address(wallet).balance); // the balance in the final (after transfer)
        // assertEq(finalBalance, initialBalance - withdrawAmount);
        //vm.stopPrank();
    }

}


// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;
import "forge-std/console.sol";

contract CollectorsWallet {

    address payable public owner;

    mapping(address => uint256) public collectors;

    constructor() {
        owner = payable(msg.sender);
        collectors[0xaC4E320Ed1235F185Bc6AC8856Ec7FEA7fF0310d] = 1;
        collectors[0x7c0FA5571c4A1A67FD21Ed9209674868cC8dc86b] = 1;
        collectors[0x7a3b914a1f0bD991BAf826F4fE9a47Bb9880d25f] = 1;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "You are not the owner");
        _;
    }

    receive() external payable {}

    // function getOwner() returns (address) {
    //     return owner;
    // }

    function withdraw(uint256 wad) external {
        console.log(msg.sender);
        console.log(address(this).balance);
        require(
            owner == msg.sender || collectors[msg.sender] == 1,
            "You are not allowed"
        );
        // require(address(this).balance >= wad, "Not Enough Money");
        payable(msg.sender).transfer(wad);
    }

    function updateCollectors(
        address oldCollector,
        address newCollector
    ) external onlyOwner {
        require(collectors[newCollector] == 1, "A Collector exist"); // check if collector exist in my hash
        collectors[newCollector] = 1;
        collectors[oldCollector] = 0;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}

```


## Vulnerability on address(0)


* https://github.com/blockchain-audit/DeFiVulnLabs

```
~/audit/DeFiVulnLabs/src main ❯ grep -rni 'address(0)' .                                                                                                                                                             13:37:10
./test/Immunefi_ch2.sol:40:        _setImplementation(address(0));
./test/fee-on-transfer.sol:210:        require(to != address(0));
./test/fee-on-transfer.sol:221:        emit Transfer(msg.sender, address(0), tokensToBurn);
./test/fee-on-transfer.sol:226:        require(spender != address(0));
./test/fee-on-transfer.sol:239:        require(to != address(0));
./test/fee-on-transfer.sol:252:        emit Transfer(from, address(0), tokensToBurn);
./test/fee-on-transfer.sol:261:        require(spender != address(0));
./test/fee-on-transfer.sol:273:        require(spender != address(0));
./test/fee-on-transfer.sol:284:        emit Transfer(address(0), account, amount);
./test/fee-on-transfer.sol:296:        emit Transfer(account, address(0), amount);
./test/ApproveScam.sol:116:        emit Transfer(address(0), msg.sender, amount);
./test/ApproveScam.sol:122:        emit Transfer(msg.sender, address(0), amount);
./test/SignatureReplayNBA.sol:88:        require(info.from != address(0), "INVALID_SIGNER");
./test/return-break.sol:94:            if (bankAddresses[i] == address(0)) {
./test/return-break.sol:129:            if (bankAddresses[i] == address(0)) {
./test/ecrecover.sol:7:Name: ecrecover returns address(0)
./test/ecrecover.sol:13:are invali, If v value isn't 27 or 28. it will return address(0).
./test/ecrecover.sol:42:        // If v value isn't 27 or 28. it will return address(0)
./test/ecrecover.sol:58:    address Admin; //default is address(0)
./test/ecrecover.sol:82:        require(_to != address(0), "Invalid recipient address");
./test/ecrecover.sol:87:        //require(signer != address(0), "Invalid signature");
```


## User Maker Switch

* https://github.com/makerdao/dss/blob/fa4f6630afb0624d04a003e920b0d71a00331d98/src/vat.sol#L109

## Debuggger

Added --debug with the funciton name

```
forge test --debug testWithdraw1 -vvv
>>>>>>> a33fc42f4cc71e6488d31b4b9e2e3e60460e0e23
```
