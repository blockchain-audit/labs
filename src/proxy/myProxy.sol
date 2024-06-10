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
    function _delegate() private{
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

contract Proxy {
    //מאחסן את עדכון כתובות המנהל והחוזה בסלוט 
    bytes32 private constant IMPLEMENTATION_SLOT =
        bytes32(uint256(keccak256("eip1967.proxy.implementation")) - 1);
    bytes32 private constant ADMIN_SLOT =
        bytes32(uint256(keccak256("eip1967.proxy.admin")) - 1);

    constructor() {
        _setAdmin(msg.sender);
    }

//אם השולח הוא המנהל -תמשיך, אם לא שולח לפולבק
    modifier ifAdmin() {
        if (msg.sender == _getAdmin()) {
            _;
        } else {
            _fallback();
        }
    }

//מחזיר את כתובת המנהל בגישה לכתובת בסלוט
    function _getAdmin() private view returns (address) {
        return StorageSlot.getAddressSlot(ADMIN_SLOT).value;
    }

//מאתחל את המנהל בסלוט, עי הכתובת שנשלחה לפונקציה, במקרה שהאדמין לא מאותחל
    function _setAdmin(address _admin) private {
        require(_admin != address(0), "admin = zero address");
        StorageSlot.getAddressSlot(ADMIN_SLOT).value = _admin;
    }

//מחזיר את כתובת החוזה המעודכן בגישה לכתובת בסלוט
    function _getImplementation() private view returns (address) {
        return StorageSlot.getAddressSlot(IMPLEMENTATION_SLOT).value;
    }

//מאתחל את כתובת החוזה בסלוט רק אם הכתובת שנשלחה לפונקציה אכן הגיונית וגדולה מאפס 
    function _setImplementation(address _implementation) private {
        require(
            _implementation.code.length > 0, "implementation is not contract"
        );
        StorageSlot.getAddressSlot(IMPLEMENTATION_SLOT).value = _implementation;
    }

    // Admin interface //
    //שולח כתובת שהתקבלה לפונקציה עי שליחה לפונקציית הסט כנל
    function changeAdmin(address _admin) external ifAdmin {
        _setAdmin(_admin);
    }

 
    //שולח לפונקציית עדכון כתובת החוזה רק אם השולח הוא המנהל
    function upgradeTo(address _implementation) external ifAdmin {
        _setImplementation(_implementation);
    }


    //מחזיר את כתובת המנהל רק אם השולח הוא המנהל
    function admin() external ifAdmin returns (address) {
        return _getAdmin();
    }

 
    // מחזיר את כתובת החוזה רק אם השולח הוא המנהל
    function implementation() external ifAdmin returns (address) {
        return _getImplementation();
    }

    // User interface //
    function _delegate(address _implementation) internal virtual {
        assembly {
            calldatacopy(0, 0, calldatasize())
            let result :=
                delegatecall(gas(), _implementation, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())
            switch result
            case 0 {
                revert(0, returndatasize())
            }
            default {
                return(0, returndatasize())
            }
        }
    }
    
    // שולח לדליגייט את מה שחוזר מפונקציית getImplementation - בתובת החוזה חכם הנוכחי
    function _fallback() private {
        _delegate(_getImplementation());
    }

    //כשיש בעיה בהזנת הנתונים הפונקציה מופעלת ושולחת לפונקציה שמעליה
    fallback() external payable {
        _fallback();
    }

    //
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

    function changeProxyAdmin(address payable proxy, address admin)
        external
        onlyOwner
    {
        Proxy(proxy).changeAdmin(admin);
    }

    function upgrade(address payable proxy, address implementation)
        external
        onlyOwner
    {
        Proxy(proxy).upgradeTo(implementation);
    }
}



library StorageSlot {
    struct AddressSlot {
        address value;
    }

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

    function getSlot() external view returns (address) {
        return StorageSlot.getAddressSlot(slot).value;
    }

    function writeSlot(address _addr) external {
        StorageSlot.getAddressSlot(slot).value = _addr;
    }
}