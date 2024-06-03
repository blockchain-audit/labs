// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

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

contract BuggyProxy {
    address public implementation;
    address public admin;

    constructor() {
        admin = msg.sender;
    }

    function delegate() private {
        (bool ok,) = implementation.delegatecall(msg.data);
        require(ok, "delegatecall failed");
    }

    fallback() external payable {
        delegate();
    }

    receive() external payable {
        delegate();
    }

    function upgradeTo(address Implementation) external {
        require(msg.sender == admin, "not authorized");
        implementation = Implementation;
    }
}

contract Dev {
    function selectors() external view returns (bytes4, bytes4, bytes4) {
        return (
            Proxy.admin.selector,
            Proxy.implementation.selector,
            Proxy.upgradeTo.selector
        );
    }
}

contract Proxy {

    bytes32 private constant IMPLEMENTATION_SLOT = bytes32(uint256(keccak256("eip1967.proxy.implementation")) - 1);
    bytes32 private constant ADMIN_SLOT = bytes32(uint256(keccak256("eip1967.proxy.admin")) - 1);

    constructor() {
        setAdmin(msg.sender);
    }

    modifier ifAdmin() {
        if (msg.sender == getAdmin()) {
            _;
        } else {
            fallBack();
        }
    }

    function getAdmin() private view returns (address) {
        return StorageSlot.getAddressSlot(ADMIN_SLOT).value;
    }

    function setAdmin(address admin) private {
        require(admin != address(0), "admin = zero address");
        StorageSlot.getAddressSlot(ADMIN_SLOT).value = admin;
    }

    function getImplementation() private view returns (address) {
        return StorageSlot.getAddressSlot(IMPLEMENTATION_SLOT).value;
    }

    function setImplementation(address implementation) private {
        require(
            implementation.code.length > 0, "implementation is not contract"
        );
        StorageSlot.getAddressSlot(IMPLEMENTATION_SLOT).value = implementation;
    }

    function changeAdmin(address admin) external ifAdmin {
        setAdmin(admin);
    }

    function upgradeTo(address implementation) external ifAdmin {
        setImplementation(implementation);
    }

    function admin() external ifAdmin returns (address) {
        return getAdmin();
    }

    function implementation() external ifAdmin returns (address) {
        return getImplementation();
    }

    function _delegate(address implementation) internal virtual {
        assembly {
            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(gas(), implementation, 0, calldatasize(), 0, 0)
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

    function fallBack() private {
        delegate(getImplementation());
    }

    fallback() external payable {
        fallBack();
    }

    receive() external payable {
        fallBack();
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
        (bool ok, bytes memory res) = proxy.staticcall(abi.encodeCall(Proxy.admin, ()));
        require(ok, "call failed");
        return abi.decode(res, (address));
    }

    function getProxyImplementation(address proxy) external view returns (address) {
        (bool ok, bytes memory res) = proxy.staticcall(abi.encodeCall(Proxy.implementation, ()));
        require(ok, "call failed");
        return abi.decode(res, (address));
    }

    function changeProxyAdmin(address payable proxy, address admin) external onlyOwner {
        Proxy(proxy).changeAdmin(admin);
    }

    function upgrade(address payable proxy, address implementation) external onlyOwner {
        Proxy(proxy).upgradeTo(implementation);
    }
}

library StorageSlot {
    struct AddressSlot {
        address value;
    }

    function getAddressSlot(bytes32 slot) internal pure returns (AddressSlot storage r) {
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

    function writeSlot(address Address) external {
        StorageSlot.getAddressSlot(slot).value = Address;
    }
}