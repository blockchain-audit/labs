// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.24;
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/store/store.sol";
import "../../src/wallet/SmartWallet.sol";

contract FuzzTestWallet is Test{
    SmartWallet  public wallet;

    // initialization
    function setUp() public {
        wallet = new SmartWallet ();
        payable(address(wallet)).transfer(100);
    }
    
    //  It checks that upon initialization, the contract is initialized with three owners,
    //and each of them is the contract itself.
    //הוא בודק שעם האתחול החוזה מאותחל עם שלושה בעלים, וכל אחד מהם הוא החוזה עצמו.


    function testInitialOwners() public {
        
         address[] memory initialOwners = wallet.getOwners(); 
         assert(initialOwners.length == 3);
         assert(initialOwners[0] == 0xAb5801a7D398351b8bE11C439e05C5B3259aeC9B);
         assert(initialOwners[1] == 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c);
         assert(initialOwners[2] == 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db);
    } 



    //the function checks that after calling the withdraw function, the balance of the contract's account decreases as expected.
    //הפונקציה בודקת כי לאחר קריאה לפונקציית המשיכה יתרת חשבון החוזה יורדת כצפוי.
    function testAllowedWithdraw(uint256 amount) public payable {
        //uint256 amount =50;
        uint256 initialBalance = address(wallet).balance;
        address userAdress = 0xAb5801a7D398351b8bE11C439e05C5B3259aeC9B;
        vm.startPrank(userAdress);
        wallet.withdraw(amount);
        assertEq(wallet.getBalance(), initialBalance - amount, "Balance should decrease after withdrawal");
        vm.stopPrank();
    }


    
    
    function testnotAllowedWithdraw( uint256 amount,address userAdress) public payable {
        uint256 initialBalance = address(wallet).balance;
        // address userAdress = vm.addr(123); 
        //איתחול לכתובת חוזה חכם
        vm.startPrank(userAdress);
        //אל תתיחס לחפונקציה הבאה, אני יודעת שהיא תחזיר שגיאה
        vm.expectRevert();
        wallet.withdraw(amount);
        assertEq(wallet.getBalance(), initialBalance, "Balance should decrease after withdrawal");
        //תחזור לכתובת חכם שלך
        vm.stopPrank();
    }

    
    //get&set
    function testGetBalance(uint256 amount) public {
        wallet.getBalance();
        //vm.expectRevert();
        console.log(amount);
        if(wallet.getBalance() == amount)
            console.log("same");
        //assertEq(wallet.getBalance(), amount,"-----");
    }


    

     function testAddOwner(address userAddress, address newOwner) public {

        address userAdress = 0xAb5801a7D398351b8bE11C439e05C5B3259aeC9B;
        vm.startPrank(userAdress);

        address oldOwner = wallet.getOneOwner();

        wallet.AddOwner(newOwner, oldOwner);


    
        address[] memory owners = wallet.getOwners();
        
        // //Search loop, checks if the new one is in the list, if so it will return true

        bool newOwnerAdded;

        for (uint256 i = 0; i < owners.length; i++) {
            if (owners[i] == newOwner) {
                newOwnerAdded = true;
                break;
            }
        
        }
        // //תפסיק להתיחס כאילו אני הבעלים
         vm.stopPrank();
         assertTrue(newOwnerAdded, "New owner should be added");
    }

}
