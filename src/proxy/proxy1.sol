// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../../lib/openzeppelin-contracts/contracts/proxy/transparent/ProxyAdmin.sol";
import "../../lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
contract HelloWorldV1 {
    string public text = "hello world";

    function setText(string memory _text) public {
        text = _text;
    }
} 

contract HelloWorldProxyDeployer {
	address public admin;
	address public proxy;
	constructor(address _implementation) {
		ProxyAdmin adminInstance = new ProxyAdmin(msg.sender);
		admin = address(adminInstance);
		TransparentUpgradeableProxy proxyInstance = new TransparentUpgradeableProxy(_implementation, admin, "");
		proxy = address(proxyInstance);
	}
}

