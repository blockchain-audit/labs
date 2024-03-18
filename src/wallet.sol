// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract wallet {
    address payable private owner;
    //address payable[] public gabaim;
    mapping (address=>uint256) public  hasgGabaim;
    constructor() {
        owner = payable(msg.sender);
        hasgGabaim[0xaC4E320Ed1235F185Bc6AC8856Ec7FEA7fF0310d]=1;
        hasgGabaim[0x7a3b914a1f0bD991BAf826F4fE9a47Bb9880d25f] =1;
        hasgGabaim[0x0638cF39b33D063c557AE2bC4B5D22a790Ac8Fe4]=1;
    }

    receive() external payable {}

    function withdraw(uint256 wad) external {
        require(
            owner == msg.sender ||hasgGabaim[msg.sender]==1,
            "Only the owner and the gabaim allowed to withdraw Ether"
        );
        payable(msg.sender).transfer(wad);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
