// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract counterV1 {
    uint256 public count;

    function inc() external {
        count += 1;
    }
}

contract counterV2 {
    uint256 public count;

    function inc() external {
        count += 1;
    }

    function dec() external {
        count -= 1;
    }
}


contract Dev {
    function selectors() external view returns (bytes4, bytes4, bytes4) {
        return (
            Proxy.admin.selector,
            Proxy.implementation.selector,
            Proxy.upgradeTo.selector,
        )
    }
}
contract Proxy {

    bytes32 private constant IMPLEMENTATION_SLOT =
        bytes32(uint256(keccak256("eip1967.proxy.implementation")) - 1); // is the contract address you’ll give to users to interact with your contract

    bytes32 private constant ADMIN_SLOT =
        bytes32(uint256(keccak256("eip1967.proxy.admin")) - 1); // is the contract to manage ownership and upgrades

    constructor() {
        _setAdmin(msg.sender); // admin initialize msg.sender
    }

    modifier ifAdmin() {
        if(msg.sender == _getAdmin()){ 
            _;
        } else {
            _fallback();
        }
    }

    function _getAdmin() private view returns (address) {
        return StorageSlot.getAddressSlot(ADMIN_SLOT).value; // return admin
    }

    function _setAdmin(address _admin) private {
        require(_admin != adddress(0), "admin = zero address"); 
        StorageSlot.getAddressSlot(ADMIN_SLOT).value = _admin;
    }
  
    function _getImplemention() private view returns (address) {
        return StorageSlot.getAddressSlot(IMPLEMENTATION_SLOT).value;
    }

    function _setImplementation(address _implementation) private {
        require(
            _implementation.code.length > 0, "implemention is not contract"
        );
        StorageSlot.getAddressSlot(IMPLEMENTATION_SLOT).value = _implementation;
    }
  
    // Admin interface //
    function changeAdmin(address _admin) external ifAdmin {
        _setAdmin(_admin);
    }

    function upgradeTo(address _implementation) external ifAdmin { // changeImplementation
        _setImplementation(_implementation);
    }

    // what the diffrence between _getAdmin() to admin()? and _getImplementation() to implementation() ??
    function admin() external ifAdmin returns (address){
        return _getAdmin();
    }

    function implementation() external ifAdmin returns (address){
        return _getImplementation();
    }

    function _delegete(address _implementation) internal virtual {
        assembly {
            calldatacopy(0,0,calldatasize())

            let result := delegatecall(gas(), _implementation, 0, calldatasize(), 0, 0)
        
            returndatacopy(0,0,returndatasize())

            switch result

            case 0 {
                revert(0, returndatasize())
            }
            default {
                revert(0, returndatasize())
            }
        }
    }

    function _fallback() private {
        _delegete(_getImplementation());
    }

    fallback() external payable {
        _fallback();
    }

    receive() external payable {
        _fallback();
    }

}

library StorageSlot {
    
    struct AddressSlot {
        address value;
    }
    
    function getAddressSlot(bytes32 slot)internal pure returns (AddressSlot storage r)
    {
        assembly {
            r.slot := slot
        }
    }
}







    


