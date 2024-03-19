// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract wallet {
    address payable private owner;

    mapping(address => uint256) public gabaim;

    constructor() {
        owner = payable(msg.sender);
        gabaim[0xaC4E320Ed1235F185Bc6AC8856Ec7FEA7fF0310d] = 1;
        gabaim[0x7c0FA5571c4A1A67FD21Ed9209674868cC8dc86b] = 1;
        gabaim[0x7a3b914a1f0bD991BAf826F4fE9a47Bb9880d25f] = 1;
    }
    modifier onlyOwner(){
        require(
            owner == msg.sender ,
            "Only the owner and the gabaim allowed to withdraw Ether");
            _;
    }
    receive() external payable {}

    function withdraw(uint256 wad) external {
        require(
            owner == msg.sender || gabaim[msg.sender] == 1,
            "Only the owner and the gabaim allowed to withdraw Ether"
        );
        payable(msg.sender).transfer(wad);
    }

    function update(address oldGabai, address newGabai) private onlyOwner{
    //    require(owner == msg.sender, "Only the owner can update"); //only owner can update gabaaim
        require(gabaim[newGabai]==1,"the gabai is exist"); // check if gabbai exist in my hash
        gabaim[newGabai]=1;
        gabaim[oldGabai]=0;

    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
