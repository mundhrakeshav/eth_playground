// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.13;

import { ABDKMath64x64 } from "src/fixed-point-math/ABDKMath64x64.sol";
import { Test } from "forge-std/Test.sol";

contract ABDKMath64x64Test is Test {
    //* ABDK MATH IS FOR SIGNED FIXED POINT NUMBERS
    using ABDKMath64x64 for uint256;
    using ABDKMath64x64 for uint128;
    using ABDKMath64x64 for int256;
    using ABDKMath64x64 for int128;

    function setUp() public {
        
    }

    function test_to_from_uint() public {
        uint256 x = 0x80000000000000000000000000000000;
        int128 y = x.fromUInt();
        uint64 z = y.toUInt();
        emit log_bytes(abi.encodePacked(y));
        emit log_bytes(abi.encodePacked(z));

    }
}
