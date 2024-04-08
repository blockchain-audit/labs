// SPDX-License-Identifier: Unlicense
// <<<<<<< HEAD
pragma solidity >=0.5.11;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../../src/wallet/SmartWallet.sol";

contract FuzzTestWallet is Test {
    
    SmartWallet public s;

    receive() external payable {}

    function setUp() public {
        s = new SmartWallet();
        testFuzz_Withdraw(0.00000001 ether);
    }

    function testFuzz_Withdraw(uint256 amount) public {
        console.log(amount);
        console.log(1 ether);
        payable(address(s)).transfer(1 ether);
        uint256 preBalance = address(this).balance;
        s.withdraw();
        uint256 postBalance = address(this).balance;
        assertEq(preBalance + 1 ether, postBalance);
    }
}

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
        bool withdrawalStatus;
        console.log(amount);
        uint256 initialBalance = address(wallet).balance;
        address userAdress = 0xAb5801a7D398351b8bE11C439e05C5B3259aeC9B;
        vm.startPrank(userAdress);
        withdrawalStatus = wallet.withdraw(amount);
        console.log(withdrawalStatus);
        if(withdrawalStatus == true){
             assertEq(wallet.getBalance(), initialBalance - amount, "Balance should decrease after withdrawal");
            }
            else
                require(withdrawalStatus == false,"The amount you are trying to withdraw is greater than your balance");

        vm.stopPrank();
    }


    function testnotAllowedWithdraw(uint256 amount,address otherAdress) public payable {
        if(otherAdress != wallet.owners(0) &&
           otherAdress != wallet.owners(1) &&
           otherAdress != wallet.owners(2) ){
            //vm.assume(otherAdress == wallet.owners(0));
            uint256 initialBalance = address(wallet).balance;
            console.log(amount);
            console.log(otherAdress);
            //איתחול לכתובת חוזה חכם
            vm.startPrank(otherAdress);
            //אל תתיחס לחפונקציה הבאה, אני יודעת שהיא תחזיר שגיאה
            vm.expectRevert();
            bool flag = wallet.withdraw(amount);
            console.log(flag);
            assertEq(wallet.getBalance() , initialBalance , "The balance has not changed");
            //תחזור לכתובת חכם שלך
            vm.stopPrank();
        }
        
    }

    
    //get&set
    function testGetBalance(uint256 amount) public {
        wallet.getBalance();
        //vm.expectRevert();
        console.log(amount);
        if(wallet.getBalance() == amount)
            console.log("same");
    }


     function testAddOwner(address newOwner) public {

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
// >>>>>>> 322bcb194b3db662628f4b58a9facd91299150d4
