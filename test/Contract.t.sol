// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

contract ContractTest is Test {
    function setUp() public {

    }

    function testExample() public {
        address x;
        uint y;

        assembly {
            sstore(0x03, 43)
            x:=and(0xffffffffffffffffffffffffffffffffffffffff, sload(0x03))
        }
        emit log_address(x);
    }
}
