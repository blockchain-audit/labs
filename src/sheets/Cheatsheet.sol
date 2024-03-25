// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.15;

interface ITest {
    function payme() external payable;
}

abstract contract TestBase{
    //virtual without implemented must to overriden
    //external - call the function only other contreact
    function nobody()external view virtual ;

    //virtual with implement may overriden
    //pure - not read and modify the state variable
    //view - not modify but can read state variable
    //internal = rpotected, possible to use function in this cotract and inherit contract
    function _ovvrideMwPlease(uint a) internal pure virtual returns(uint){
        return a;
    }
    
    //possible to ovveride in other contract
    function overidableByStateVariable() external virtual returns(uint){
        return 1;
    }

    //can to ovveriden but not overload
    modifier checker()virtual;

}

    contract TestBase2{
        
    }
