pragma solidity ^0.8.0;
import "@hack/AMM/MyToken.sol"; // Importing your token contract

contract WalletDistributor {
    address public owner;
    IERC20 public immutable myToken;

   constructor(address _owner, address _myToken) {
        owner = _owner;
        myToken = IERC20(_myToken);
    }

    function distribute(address[] memory recipients,uint amount) public payable {
        require(msg.sender == owner, "Only owner can distribute funds");
        require(recipients.length > 0, "No recipients specified");
        uint256 amountPerRecipient = amount / recipients.length;
        require(amountPerRecipient > 0, "Amount per recipient is too low");

        for (uint i = 0; i < recipients.length; i++) {
           myToken.transferFrom(owner,recipients[i],amountPerRecipient);
        }
    }

   
}