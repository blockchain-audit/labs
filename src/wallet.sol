// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;
contract Wallet2 {
    address payable public owner;
    address [3] public owners;
    // uint256 public state = 0;
    // bool public checkRoom = true;
    mapping (address => uint256) public balances;
    constructor() {
        owner = payable(msg.sender);
    }
    receive() external payable {}
    function receiveit() external payable {
        balances[msg.sender] += msg.value;
    }
    function withdraw(uint wad) external {
        // require(msg.sender == owner, "WALLET-not-owner");
        if(msg.sender == owners[0] || msg.sender == owners[1] || msg.sender == owners[2] || msg.sender == owner) {
             payable(msg.sender).transfer(wad);
        }
     //   balances[msg.sender] -= wad;
       
    }
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
    function insert(address ownerAddress) public {
        if(msg.sender == owner  ) {
              if(owners[0] == address(0))
              owners[0] = ownerAddress;
              else if(owners[1] == address(0))
                owners[1] = ownerAddress;
                else if(owners[2] == address(0))
                    owners[2] = ownerAddress;
        }
        require(msg.sender == owner, "noly owner can insert anew address");
    }
    function remove (address ownerAddress) public {
        if(msg.sender == owner) {
            if(owners[0] == ownerAddress)
                owners[0] = address(0);
            else if(owners[1] == ownerAddress)
                owners[1] = address(0);
                else if(owners[2] == ownerAddress)
                    owners[2] = address(0);
                    else
                        require(owners[0] == ownerAddress||owners[1] == ownerAddress||owners[2] == ownerAddress,"condition");
        }
        require(msg.sender == owner, "noly owner can remove address");
    }
    function replace(address oldOwner, address newOwner) public {
        if(msg.sender == owner) {
            if(owners[0] == oldOwner)
                owners[0] = newOwner;
            else if(owners[1] == oldOwner)
                owners[1] = newOwner;
                else if(owners[2] == oldOwner)
                    owners[2] = newOwner;
        }
        require(msg.sender == owner, "noly owner can insert replace address");
    }
}


