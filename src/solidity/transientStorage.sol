pragma solidity ^0.8.24;

interface Itest{
    function val() external view returns (uint256);
    function test() external;
}

contract callback {
    uint256 public val;

    fallback() external {
        val = Itest(msg.sender).val();
    }

    function test(address target) external {
        Itest(target).test();
    }
}
contract testStorage{
    uint256 public val;

    function test() external {
        val = 123;
        bytes memory b = "";
        msg.sender.call(b);
    }
}
contract testTransientStorage {
    bytes32 constant SLOT = 0;

    function test() public {
        assembly {
            tstore(SLOT, 321)
        }
        bytes memory b = "";
        msg.sender.call(b);
    }

    function val() public view returns (uint256 v) {
        assembly {
            v := tload(SLOT)
        }
    }
}