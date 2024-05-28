



``` solidity
pragma solidity ^0.8.7;

contract Box {
    uint256 private _value;

    event NewValue(uint256 newValue);

    function store(uint256 newValue) public {
        _value = newValue;
        emit NewValue(newValue);
    }

    function retrieve() public view returns (uint256) {
        return _value;
    }
}
```



```
pragma solidity ^0.8.7;

contract Box {
    uint256 public value;

    function store(uint256 newValue) public {
        assembly {
            // store value at slot 0 of storage
            sstore(0, newValue)

            // emit event
            mstore(0x80, newValue)
            log1(0x80, 0x20, 0xac3e966f295f2d5312f973dc6d42f30a6dc1c1f76ab8ee91cc8ca5dad1fa60fd)
        }
    }

    function retrieve() public view returns(uint256) {
        assembly {
            // load value at slot 0 of storage
            let v := sload(0)

            // store into memory at 0
            mstore(0x80, v)

            // return value at 0 memory address of size 32 bytes
            return(0x80, 32)
        }
    }

}
```


```yul
object "Box" {
    code {
        let runtime_size := datasize("runtime")
        let runtime_offset := dataoffset("runtime")
        datacopy(0, runtime_offset, runtime_size)
        return(0, runtime_size)
    }

    object "runtime" {
        code {
            switch selector()

            // retrieve function match
            case 0x2e64cec1 {
                let memloc := retrieve()
                return(memloc, 32)
            }

            // store function match
            case 0x6057361d {
                store(calldataload(4))
            }

            // revert if no match
            default {
                revert(0, 0)
            }

            function retrieve() -> memloc {
                let val := sload(0)
                memloc := 0
                mstore(memloc, val)
            }

            function store(val) {
                sstore(0, val)
                mstore(0, val)
                log1(0x80, 0x20,0xac3e966f295f2d5312f973dc6d42f30a6dc1c1f76ab8ee91cc8ca5dad1fa60fd)
            }

            function selector() -> s {
                    s := div(calldataload(0),
                    0x100000000000000000000000000000000000000000000000000000000)
            }
        }
    }
}
```
