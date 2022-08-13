// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

contract ContractTest is Test {
    function setUp() public {

    }

    function testExample() public {
        uint128 x = 0x12;
        uint y = 0x12;
        emit log_bytes(abi.encodePacked(x));
        emit log_bytes(abi.encodePacked(y<<128));
    }
}
