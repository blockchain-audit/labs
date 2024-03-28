// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;
import "forge-std/console.sol";
contract Wallet {
    address payable public owner;
   // address [3] public owners;
    // uint256 public state = 0;
    // bool public checkRoom = true;
    uint sumOfGabaim ;
    mapping (address => bool) public gabaim;

    constructor() {
       // owner = payable(address(msg.sender));
       owner= payable(0x29392969D235eA463A6AA42CFD4182ED2ecB5117);
        // owners[0]=0x074AC318E0f004146dbf4D3CA59d00b96a100100;
        // owners[1] = 0x29392969D235eA463A6AA42CFD4182ED2ecB5117;
        // owners[2] =  0x074AC318E0f004146dbf4D3CA59d00b96a100100;
        gabaim[0x074AC318E0f004146dbf4D3CA59d00b96a100100] = true;
        gabaim[0x29392969D235eA463A6AA42CFD4182ED2ecB5117] = true;
        gabaim[0x29392969D235eA463A6AA42CFD4182ED2ecB5117] = true;
        sumOfGabaim = 3;

    }

    receive() external payable {}
    
    // function receiveit() external payable {
    //     gabaim[msg.sender] += msg.value;
    // }
    

    function withdraw(uint wad) external {
        // require(msg.sender == owner, "WALLET-not-owner");
        //  if(msg.sender == owners[0] || msg.sender == owners[1] || msg.sender == owners[2] || msg.sender == owner) {
        //      payable(msg.sender).transfer(wad);
        //  }
        require(gabaim[msg.sender] || msg.sender == owner,"only owner ");
        payable(msg.sender).transfer(wad);
        console.log("msg.sender",msg.sender.balance);
        console.log("this",address(this).balance);
        console.log("owner",address(owner).balance);
     //   balances[msg.sender] -= wad;
       
    }
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }

    function insert(address ownerAddress) public {
        require(msg.sender == owner, "noly owner can insert anew address");
      require(sumOfGabaim < 3 && !gabaim[ownerAddress], "ther is no room");
            gabaim[ownerAddress] = true;
            sumOfGabaim++;
            //   if(owners[0] == address(0))
            //   owners[0] = ownerAddress;
            //   else if(owners[1] == address(0))
            //     owners[1] = ownerAddress;
            //     else if(owners[2] == address(0))
            //         owners[2] = ownerAddress;
                
        
        
    }

    function remove (address ownerAddress) public {
         require(msg.sender == owner, "noly owner can remove address");
         require(gabaim[ownerAddress] , "this gabai address is not exist");
         require( ownerAddress!= owner , "cant remov the owner");
         delete gabaim[ownerAddress];
         sumOfGabaim--;
            // if(owners[0] == ownerAddress)
            //     owners[0] = address(0);
            // else if(owners[1] == ownerAddress)
            //     owners[1] = address(0);
            //     else if(owners[2] == ownerAddress)
            //         owners[2] = address(0);
            //         else
            //             require(owners[0] == ownerAddress||owners[1] == ownerAddress||owners[2] == ownerAddress,"condition");
       
       
    }
    
    function replace(address oldOwner, address newOwner) public {
         require(msg.sender == owner, "noly owner can  replace gabaim");
        require(gabaim[oldOwner] , "ther isn't gabai white this address");
        delete gabaim[oldOwner];
        gabaim[newOwner] = true;

       
          
       
    }
}


