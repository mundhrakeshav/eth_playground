// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Test } from "forge-std/Test.sol";
import { ImplContract, UnderstandingDelegateCall } from "src/proxy-pattern/UnderstandingDelegateCall.sol";

contract UnderstandingDelegateCallTest is Test {

    ImplContract implContract;
    UnderstandingDelegateCall understandingDelegateCall;

    function setUp() public {
        implContract = new ImplContract();
        understandingDelegateCall = new UnderstandingDelegateCall(); 
    }

   function testDelegateCall_updateSlot1() public {
        (bool _success, bytes memory data) = understandingDelegateCall.makeDelegateCall(
                            (implContract), abi.encodeWithSelector(ImplContract.updateSlot1.selector, 5)); // Executes updateSlot1 in own context, hence updates the variable slot1
        assertEq(understandingDelegateCall.slot1(), 5);
    }
}