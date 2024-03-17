// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract wallet {
    address payable private owner;
    address payable[] public gabaim;

    constructor(address payable[] memory _gabaim) {
        owner = payable(msg.sender);
        for (uint256 i = 0; i < _gabaim.length; i++) {
            gabaim.push(_gabaim[i]);
        }
    }

    receive() external payable {}

    function withdraw(uint256 wad) external {
        require(
            owner == msg.sender ||gabaim[0]==msg.sender||gabaim[1]==msg.sender||gabaim[2]==msg.sender,
            "Only the owner and the gabaim allowed to withdraw Ether"
        );
        payable(msg.sender).transfer(wad);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
