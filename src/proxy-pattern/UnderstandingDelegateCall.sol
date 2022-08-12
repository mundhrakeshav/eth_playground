// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import { ImplContract } from "./Implementation.sol";

contract UnderstandingDelegateCall {
    uint256 public slot1;
    uint256 public slot2;

    function makeDelegateCall(ImplContract _implContract, bytes calldata _callData) public returns(bool _success, bytes memory _data){
        (_success, _data) = address(_implContract).delegatecall(_callData);
        require(_success);
    }
}
