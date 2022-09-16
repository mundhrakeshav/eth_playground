pragma solidity ^0.8.0;

import { ERC20 } from "solmate/tokens/ERC20.sol";

contract Token is ERC20 {
  constructor(
    string memory name,
    string memory symbol,
    uint256 initialSupply
  ) ERC20(name, symbol, 18) {
    _mint(msg.sender, initialSupply);
  }
}