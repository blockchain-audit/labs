pragma solidity ^0.8.20;

import "forge-std/console.sol";
import {Test, console} from "forge-std/Test.sol";
import "@openzeppelin/ERC20/ERC20.sol";
import "@openzeppelin/ERC20/extensions/ERC20Permit.sol";

contract MyToken is ERC20 {
    constructor() ERC20("MyToken", "MTK") {
        //this;
    }

    function mint(address myAddress, uint amount) public {
        _mint(myAddress, amount);
    }
}

// forge create --rpc-url https://rpc.ankr.com/polygon_mumbai --private-key bec5ddfe6d7440a5a24ef959d508a3554b3e21774a2ad9b3e1c3c705af22235f src/myToken.sol:MyToken --legacy

//output:
//[⠒] Compiling...
//No files changed, compilation skipped
//Deployer: 0x057bB196e8f0326AFc453d2bcd1fCfCb4F879AfA  // My address of wallet in metamask
//Deployed to: 0xcdBB49fB5851d90E27D8C2a22D65BB85ACEb4224
//Transaction hash: 0xda9a7fe8da080ad460317f672196a3a15d1e90248c6ea0471f2e451269c300b3

//--command 
// cast send 0x26313e7f1c209beDd198CCfCca85cc15d14Ab4CA 'mint(address, uint)' 0x057bB196e8f0326AFc453d2bcd1fCfCb4F879AfA 1000000000000000000000000 --rpc-url https://rpc.ankr.com/polygon_mumbai --private-key bec5ddfe6d7440a5a24ef959d508a3554b3e21774a2ad9b3e1c3c705af22235f
// cast send 0xcdBB49fB5851d90E27D8C2a22D65BB85ACEb4224 'mint(address, uint)' 0x057bB196e8f0326AFc453d2bcd1fCfCb4F879AfA 1000000000000000000000000 --rpc-url https://rpc.ankr.com/polygon_mumbai --private-key bec5ddfe6d7440a5a24ef959d508a3554b3e21774a2ad9b3e1c3c705af22235f