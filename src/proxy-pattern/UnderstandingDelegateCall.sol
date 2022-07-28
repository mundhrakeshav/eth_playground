// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

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

contract UnderstandingDelegateCall {
    uint256 public slot1;
    uint256 public slot2;

    function makeDelegateCall(ImplContract _implContract, bytes calldata _callData) public returns(bool _success, bytes memory _data){
        (_success, _data) = address(_implContract).delegatecall(_callData);
        require(_success);
    }
}
