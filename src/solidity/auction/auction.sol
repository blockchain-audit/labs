// SPDX-License-Identifier: MIT

    pragma solidity ^0.8.20;
    
    import "forge-std/console.sol";

    contract Auction{
               uint [10] public owner = [10,20,30,50,100];
               mapping(uint => uint) public myMapping;
               //מערך דימני
               uint [] public dinami;
               constructor(){

               }
                // myMapping[1] = 1;
                // myMapping[2] = 2;
                // myMapping[3] = 3;
                // myMapping[4] = 4;
                // myMapping[5] = 5;
                // myMapping[6] = 6;
                // myMapping[7] = 7;
                mapping(uint => uint) public AAA;

    function insertData() public {
        for (uint i = 1; i <= 10; i++) {
            AAA[i] = i;
        }
    }

                // console.log("AAAAAAAAAAAAAAAAAA");
                // console.log(myMapping);
    }