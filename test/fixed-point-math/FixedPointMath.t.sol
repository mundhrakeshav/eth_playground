// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.13;

import { FixedPoint } from "src/fixed-point-math/FixedPointMath.sol";
import { Test } from "forge-std/Test.sol";

contract ProxyTest is Test {
    using FixedPoint for uint112;
    using FixedPoint for FixedPoint.uq112x112;
    function setUp() public {
        
    }

    function test_encode_and_decode() public {
        uint112 x = 32;
        uint112 y = 3;
        FixedPoint.uq112x112 memory m = x.encode(y);
        emit log_uint(m.x);
        emit log_bytes(abi.encodePacked(m.x));
        uint256 n = m.decode112with18();
        emit log_uint(n);
        emit log_bytes(abi.encodePacked(n));
        assertEq((x*100) / y, n / 1e16);
   }
}