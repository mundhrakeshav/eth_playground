pragma solidity ^0.8.0;
import { ERC20 } from "solmate/tokens/ERC20.sol";

contract Exchange is ERC20("KUNI LP", "KUNI", 18) {
  address public tokenAddress;

  constructor(address _token) {
    require(_token != address(0), "invalid token address");

    tokenAddress = _token;
  }

    function addLiquidity(uint _tokenAmount) public payable {
      ERC20 token = ERC20(tokenAddress);
      if(getReserve() == 0) {
        token.transferFrom(msg.sender, address(this), _tokenAmount);
        _mint(msg.sender, address(this).balance);
      } else {
        // uint256 ethReserve = address(this).balance - msg.value;
        // uint256 tokenReserve = getReserve();
        uint256 _expectedTokenAmount = (msg.value * getReserve()) / (address(this).balance - msg.value);
        require(_tokenAmount >= _expectedTokenAmount, "Insufficient Token Amt");
        token.transferFrom(msg.sender, address(this), _expectedTokenAmount); //Only pull the desired amt of tokens
        uint _liquidityToMint = (totalSupply * msg.value)/ address(this).balance;
        _mint(msg.sender, _liquidityToMint);
      }
    }

    function removeLiquidity(uint256 _amount) public {
      require(_amount > 0, "invalid amount");
      uint256 ethAmount = (address(this).balance * _amount) / totalSupply;
      uint256 tokenAmount = (getReserve() * _amount) / totalSupply;
      _burn(msg.sender, _amount);
      payable(msg.sender).transfer(ethAmount);
      ERC20(tokenAddress).transfer(msg.sender, tokenAmount);
    }

    function getReserve() public view returns (uint256) {
        return ERC20(tokenAddress).balanceOf(address(this));
    }

  function getPrice(uint256 inputReserve, uint256 outputReserve) public pure returns(uint256) {
    require(inputReserve > 0 && outputReserve > 0, "invalid reserves");
    return inputReserve / outputReserve;
  }

  function getAmount(uint256 inputAmount, uint256 inputReserve, uint256 outputReserve) private pure returns (uint256) {
    require(inputReserve > 0 && outputReserve > 0, "invalid reserves");
    uint256 _inputAMtWithFee = inputAmount * 100;
    uint256 _numerator = _inputAMtWithFee * outputReserve;
    uint256 _denominator = (inputReserve * 100) + inputAmount;
    return _numerator/_denominator;
  }
  
  function getTokenAmount(uint256 _ethSold) public view returns (uint256) {
    require(_ethSold > 0, "ethSold is too small");
    uint256 tokenReserve = getReserve();
    return getAmount(_ethSold, address(this).balance, tokenReserve);
  }

  function getEthAmount(uint256 _tokenSold) public view returns (uint256) {
    require(_tokenSold > 0, "tokenSold is too small");
    uint256 tokenReserve = getReserve();
    return getAmount(_tokenSold, tokenReserve, address(this).balance);
  }

  function ethToTokenSwap(uint256 _minTokens) public payable {
    uint256 tokenReserve = getReserve();
    uint256 tokensBought = getAmount(msg.value, address(this).balance - msg.value, tokenReserve);
    require(tokensBought >= _minTokens, "insufficient output amount");
    ERC20(tokenAddress).transfer(msg.sender, tokensBought);
  }

  function tokenToEthSwap(uint256 _tokensSold, uint256 _minEth) public {
    uint256 tokenReserve = getReserve();
    uint256 ethBought = getAmount(_tokensSold,  tokenReserve,  address(this).balance);
    require(ethBought >= _minEth, "insufficient output amount");
    ERC20(tokenAddress).transferFrom(msg.sender, address(this), _tokensSold);
    payable(msg.sender).transfer(ethBought);
  }

}