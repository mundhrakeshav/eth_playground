// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Test } from "forge-std/Test.sol";
import { ImplContract } from "src/proxy-pattern/Implementation.sol";
import { Proxy } from "src/proxy-pattern/Proxy.sol";
import { console } from "forge-std/console.sol";

contract ProxyTest is Test {
    ImplContract implContract;
    Proxy proxy;
    // function setUp() public {
    //     implContract = new ImplContract();
    //     emit log_named_address("Impl", address(implContract));
    //     proxy = new Proxy(address(implContract));
    //     emit log_named_address("Proxy", address(proxy));
    // }

    function test_proxy() public {
        assembly {
            calldatacopy(0, 0, calldatasize())
        }
        emit log_bytes(msg.data);
    }

    function execute(bytes calldata _data) public {
        bytes memory x;
        x = msg.data;
    }

}