// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.13;

contract ImplContract {

    uint256 slot1;
    uint256 slot2;

    function updateSlot1(uint256 _num) public {
        slot1 = _num;        
    }

    function updateSlot2(uint256 _num) public {
        slot2 = _num;        
    }
}