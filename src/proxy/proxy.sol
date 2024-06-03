// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Transparent upgradeable proxy pattern

contract CounterV1 {
    uint256 public count;

    function inc() external {
        count += 1;
    }
}

contract CounterV2 {
    uint256 public count;

    function inc() external {
        count += 1;
    }

    function dec() external {
        count -= 1;
    }
}

//החוזה מאפשר למעשה לעדכן את הפונקציות של החוזה הראשי ללא שינוי הכתובת, כך שכל קריאה לכתובת החוזה תועבר לחוזה המיושם הנוכחי.
contract BuggyProxy {

    address public implementation; //כתובת החוזה המיושם
    address public admin;  // כתובת המנהל שיש לו הרשאה לשדרג את החוזה

    constructor() {
        //מאתחל את המנהל ככתובת של החוזה
        admin = msg.sender;
    }


    //delegatecall שהתקבל בפונקציה הנוכחית באמצעות msg.data עם אותו implementation מבצעת קריאה לכתובת 
    //"delegatecall failed" אם הקריאה נכשלת, היא מחזירה שגיאה עם הודעה 
    function _delegate() private {
        (bool ok,) = implementation.delegatecall(msg.data);
        require(ok, "delegatecall failed");
    }

    // משמשות לניהול קריאות שנשלחות לחוזה כשאין התאמה לפונקציה קיימת או כשנשלחים כספים לחוזהfallback & receive
    
    //מופעלת באופן אוטומטי כאשר החוזה מקבל קריאה לפונקציה שאינה קיימת או כאשר נתונים נשלחים לחוזה ללא התאמה לפונקציה קיימת.
    fallback() external payable {
        _delegate();
    }

    //מופעלת כאשר נשלחים כספים לחוזה בלי לצרף נתונים
    receive() external payable {
        _delegate();
    }

    //implementation מאפשרת למנהל (ולמנהל בלבד) לשדרג את החוזה המיושם על ידי עדכון הכתובת של 
    function upgradeTo(address _implementation) external {
        require(msg.sender == admin, "not authorized");
        implementation = _implementation;
    }
}

contract Dev {
    function selectors() external view returns (bytes4, bytes4, bytes4) {
        return (
            Proxy.admin.selector,   //הפונקציה שמחזירה את כתובת המנהל של החוזה
            Proxy.implementation.selector,   //הפונקציה שמחזירה את כתובת המימוש הנוכחי של החוזה
            Proxy.upgradeTo.selector  //הפונקציה שמאפשרת למנהל לשדרג את החוזה למימוש חדש
        );
    }
}

contract Proxy {
    // All functions / variables should be private, forward all calls to fallback

    // -1 for unknown preimage
    // 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc
    bytes32 private constant IMPLEMENTATION_SLOT =
        //השורה מייצרת מזהה ייחודי המייצג כתובת בחוזה
        //keccak256 של המחרוזת באמצעות פונקציית ה hash יצירת ה 
        bytes32(uint256(keccak256("eip1967.proxy.implementation")) - 1);
    // 0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103
    bytes32 private constant ADMIN_SLOT =
        bytes32(uint256(keccak256("eip1967.proxy.admin")) - 1);

    constructor() {
        _setAdmin(msg.sender);
    }

    modifier ifAdmin() {
        //הבדיקה היא האם השולח של הפעולה הוא המנהל הנוכחי של החוזה
        if (msg.sender == _getAdmin()) {
            _;
        } else {
            _fallback();
        }
    }

    //מחזירה את כתובת המנהל הנוכחי של החוזה
    function _getAdmin() private view returns (address) {
        return StorageSlot.getAddressSlot(ADMIN_SLOT).value;
    }

    // מאפשרת לשנות את הכתובת של המנהל של החוזה
    function _setAdmin(address _admin) private {
        require(_admin != address(0), "admin = zero address");
        StorageSlot.getAddressSlot(ADMIN_SLOT).value = _admin;
    }

    //מחזירה את הכתובת של המימוש הנוכחי של החוזה
    function _getImplementation() private view returns (address) {
        return StorageSlot.getAddressSlot(IMPLEMENTATION_SLOT).value;
    }

    //הפונקציה מגדירה את הכתובת החדשה של המימוש בסלוט המיוחד המתאים ובכך מעדכנת את המימוש של החוזה
    function _setImplementation(address _implementation) private {
        require(
            _implementation.code.length > 0, "implementation is not contract"
        );
        StorageSlot.getAddressSlot(IMPLEMENTATION_SLOT).value = _implementation;
    }
    // _setAdmin לchangeAdmin ההבדל בין 
    //_setAdmin - אינה בודקת אם השולח הוא המנהל הנוכחי של החוזה. זה אומר שכל אחד שיש לו גישה להפעיל את הפונקציה
    // changeAdmin -  כדי לוודא שהשולח הוא המנהל הנוכחי של החוזה. רק אם התנאי יתקיים, השינוי במנהל יתבצע. בכך, נעשה בדיקת זהות לפני ביצוע השינוי ifAdmin  משתמשת במודיפייר
    // Admin interface //
    //שינוי המנהל של החוזה
    function changeAdmin(address _admin) external ifAdmin {
        _setAdmin(_admin);
    }

    // 0x3659cfe6
    //מאפשרת למנהל החוזה לשדרג את המימוש של החוזה למימוש חדש. היא מאפשרת זאת רק אם השולח של הפעולה הוא המנהל הנוכחי של החוזה
    function upgradeTo(address _implementation) external ifAdmin {
        _setImplementation(_implementation);
    }

    // 0xf851a440
    //מחזירה את כתובת המנהל הנוכחי של החוזה רק אם הוא המנהל בעצמו
    function admin() external ifAdmin returns (address) {
        return _getAdmin();
    }

    // 0x5c60da1b
    // מחזירה את כתובת המימוש הנוכחי של החוזה רק אם הוא המנהל בעצמ. 
    function implementation() external ifAdmin returns (address) {
        return _getImplementation();
    }

    // User interface //
    //מקבלת את כתובת המימוש 
    // עושה קריאה לפונקציה אחרת בחוזה. היא מכניסה את כל הנתונים שנשלחו עם הקריאה לפונקציה אל הזיכרון של החוזה.
    // לאחר מכן, היא מבצעת קריאה דינמית לפונקציה המתאימה במימוש הנתון בתוך החוזה. לאחר הקריאה, התוצאה מוחזרת ונבדקת. 
    //אם הקריאה נכשלה, היא תקפיץ חריגה. אם הקריאה הצליחה, היא תחזיר את התוצאה.
    //נתונים - פרמטרים, ערכים, וכל נתון נוסף שידרוש הפונקציה לביצועה
    function _delegate(address _implementation) internal virtual {
        assembly {
            // Copy msg.data. We take full control of memory in this inline assembly
            // block because it will not return to Solidity code. We overwrite the
            // Solidity scratch pad at memory position 0.

            // calldatacopy(t, f, s) - copy s bytes from calldata at position f to mem at position t
            // calldatasize() - size of call data in bytes
            
            //פונקציה זו מכניסה את כל הנתונים שנשלחו עם הקריאה לפונקציה אל הזיכרון של החוזה
            calldatacopy(0, 0, calldatasize())

            // Call the implementation.
            // out and outsize are 0 because we don't know the size yet.

            // delegatecall(g, a, in, insize, out, outsize) -
            // - call contract at address a
            // - with input mem[in…(in+insize))
            // - providing g gas
            // - and output area mem[out…(out+outsize))
            // - returning 0 on error (eg. out of gas) and 1 on success

            //השורה הזו עושה קריאה לפונקציה מסוימת בתוך החוזה. היא מעבירה לפונקציה את הגז הנדרש לביצוע הפעולה, 
            //result את כתובת המימוש של הפונקציה, ואת הנתונים הנשלחים עם הקריאה. לאחר ביצוע הפונקציה, התוצאה מוחזרת ומיוצגת במשתנה 
            let result :=
                delegatecall(gas(), _implementation, 0, calldatasize(), 0, 0)

            // Copy the returned data.
            // returndatacopy(t, f, s) - copy s bytes from returndata at position f to mem at position t
            // returndatasize() - size of the last returndata
            returndatacopy(0, 0, returndatasize())

            switch result
            // delegatecall returns 0 on error.
            case 0 {
                // revert(p, s) - end execution, revert state changes, return data mem[p…(p+s))
                revert(0, returndatasize())
            }
            default {
                // return(p, s) - end execution, return data mem[p…(p+s))
                return(0, returndatasize())
            }
        }
    }

    function _fallback() private {
        _delegate(_getImplementation());
    }

    fallback() external payable {
        _fallback();
    }

    receive() external payable {
        _fallback();
    }
}

contract ProxyAdmin {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }

    //ומחזירה את כתובת האדמין שלו proxy מקבלת כתובת של חוזה 
    //proxy כתובת האדמין של החוזה היא הכתובת של המנהל או המבקש שינויים בחוזה ושינויים בהתנהלותו. במקרה של חוזה 
    // האדמין הוא הכתובת של האדם או החשבון שיכול לבצע פעולות כמו שדרושות, כגון עדכון של המימוש של החוזה או שינוי בהרשאות
    // זהו מנהל החוזה שבאמצעותו ניתן לנהל את פעולותיו ולהגדיר את התנאים שלו.
    function getProxyAdmin(address proxy) external view returns (address) {
        (bool ok, bytes memory res) =
            proxy.staticcall(abi.encodeCall(Proxy.admin, ()));
        require(ok, "call failed");
        return abi.decode(res, (address));
    }

    function getProxyImplementation(address proxy)
        external
        view
        returns (address)
    {
        (bool ok, bytes memory res) =
            proxy.staticcall(abi.encodeCall(Proxy.implementation, ()));
        require(ok, "call failed");
        return abi.decode(res, (address));
    }

    //מחזירה את כתובת המימוש הנוכחי של החוזה הזה
    function changeProxyAdmin(address payable proxy, address admin)
        external
        onlyOwner
    {
        Proxy(proxy).changeAdmin(admin);
    }

    //Proxy מאפשרת לבעל החוזה לשדר התראה לחוזה מסוג
    //ולשדר את כתובת המימוש החדשה של הקוד upgradeTo כדי לשדר אותו לעדכון או שדר אותו לקריאה לפונקציה 
    function upgrade(address payable proxy, address implementation)
        external
        onlyOwner
    {
        Proxy(proxy).upgradeTo(implementation);
    }
}

//ספריית סיוע שמכילה פונקציות לגישה ולניהול גישה לאחסון בזיכרון המחשב בתוך החוזה
library StorageSlot {
    //מיועד לאחסון כתובות
    struct AddressSlot {
        address value;
    }

    //הפונקציה משתמשת באסמבליה כדי לשמור את כתובת המיקום בזיכרון המקומי של החוזה ולהחזיר גישה למיקום זה
    function getAddressSlot(bytes32 slot)
        internal
        pure
        returns (AddressSlot storage r)
    {
        assembly {
            r.slot := slot
        }
    }
}

contract TestSlot {
    bytes32 public constant slot = keccak256("TEST_SLOT");

    //מחזירה את הכתובת שנמצאת בתא הזיכרון המקושר למפתח זה
    function getSlot() external view returns (address) {
        return StorageSlot.getAddressSlot(slot).value;
    }

    //מאפשרת לכתוב ערך חדש לתא הזיכרון המקושר למפתח זה
    function writeSlot(address _addr) external {
        StorageSlot.getAddressSlot(slot).value = _addr;
    }
}