// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/store/store.sol";
import "lib/hardhat/console.sol";

contract TestWallet  {
    SmartWallet  public wallet;

    // initialization
    function setUp() public {
        wallet = new SmartWallet (); 
    }
    
    //  It checks that upon initialization, the contract is initialized with three owners,
    //and each of them is the contract itself.
    //הוא בודק שעם האתחול החוזה מאותחל עם שלושה בעלים, וכל אחד מהם הוא החוזה עצמו.

    function testInitialOwners() public {
        address[] memory initialOwners = wallet.owners();

        Assert.equal(initialOwners.length, 3, "Initial owners should be 3");
        Assert.equal(initialOwners[0], address(this), "First owner should be this contract");
        Assert.equal(initialOwners[1], address(this), "Second owner should be this contract");
        Assert.equal(initialOwners[2], address(this), "Third owner should be this contract");
    }
    

    //the function checks that after calling the withdraw function, the balance of the contract's account decreases as expected.
    //הפונקציה בודקת כי לאחר קריאה לפונקציית המשיכה יתרת חשבון החוזה יורדת כצפוי.
    function testWithdraw() public payable {
        uint256 amount = 100 wei;
        uint256 initialBalance = address(wallet).balance;

        wallet.withdraw(amount);

        Assert.equal(address(wallet).balance, initialBalance - amount, "Balance should decrease after withdrawal");
    }
    
    //get&set
    function testSetAndGetValue(uint256 value) public {
        w.setValue(value);
        console.log(value);
        console.log(s.getValue());
        assertEq(value, s.getValue());
    }


    //

     function testAddOwner() public {

        //Setting 2 variables + initialization
        address newOwner = address(0x123);
        address oldOwner = address(this);

        //A call to the addOwner function
        wallet.addOwner(newOwner, oldOwner);
        
        //Initialization of an array with the new owners
        address[] memory owners = wallet.owners();
        
        //Search loop, checks if the new one is in the list, if so it will return true
        bool newOwnerAdded;
        for (uint256 i = 0; i < owners.length; i++) {
            if (owners[i] == newOwner) {
                newOwnerAdded = true;
                break;
            }
        }
        
        //Checks whether the new owner has been added or not if you don't get an error message:
        // "New owner should be added" will be displayed.
        assertTrue(newOwnerAdded, "New owner should be added");
    }

}

