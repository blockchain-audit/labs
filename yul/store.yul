// solc --strict-assembly --optimize --optimize-runs 200 add.yul

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

