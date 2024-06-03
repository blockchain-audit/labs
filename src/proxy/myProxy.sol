// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Transparent upgradeable proxy pattern
//חוזה עם פונקציה אחת שמגדילה את המשתנה ב-1
contract CounterV1 {
    uint256 public count;

    function inc() external {
        count += 1;
    }
}
//חוזה עם שתי פונקציות - אחת מגדילה את המשתנה 
//ואחת מקטינה אותו
contract CounterV2 {
    uint256 public count;

    function inc() external {
        count += 1;
    }

    function dec() external {
        count -= 1;
    }
}

//
contract BuggyProxy {
    address public implementation;//חוזה חכם ולא כתובת רגילה
    address public admin;

//מאתחל את האדמין
    constructor() {
        admin = msg.sender;
    }


//implementation הפונקציה ניגשת לחוזה 
//delegatecall ומפעילה את הפונקציה 
// ומחזירה משתנה ומאתחלת את אוקי מסוג בוליאני
    function _deligate() private{
        (bool ok) = implementation.deligatecall(msg.sender);
        require(ok,"delegatecall failed");
    }
//מופעל אוטומטית כשקוראים לחוזה
//והזנת הנתונים אינה נכונה
    fallback() external payable {
        _delegate();
    }
//
    receive() external payable {
        _delegate();
    }

//מעדכן את החוזה החכם לחוזה שנשלח לפונקציה
    function upgradeTo(address _implementation) external {
        require(msg.sender == admin, "not authorized");
        implementation = _implementation;
    }
}


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
