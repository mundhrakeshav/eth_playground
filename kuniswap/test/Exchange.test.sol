// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Test } from "forge-std/Test.sol";
import { Exchange } from "src/Exchange.sol";
import { Token } from "src/Token.sol";

contract ExchangeTest is Test {
    
    Token token;
    Exchange exchange;
    address lp1 = address(1);
    function setUp() public {
    startHoax(lp1);
    token = new Token("TestToken", "TEST", 1e30);
    exchange = new Exchange(address(token));
    
    }

    function test_AddLiquidity() public {
        token.approve(address(exchange), 200 ether);
        exchange.addLiquidity{value: 100 ether}(200 ether);
        assertEq(exchange.getReserve(), 200 ether);
        assertEq(address(exchange).balance, 100 ether);
    }

    function test_GetEthAmount() public {
        token.approve(address(exchange), 200 ether);
        exchange.addLiquidity{value: 100 ether}(200 ether);
        assertEq(exchange.getReserve(), 200 ether);
        assertEq(address(exchange).balance, 100 ether);
        //Liquidity Added
        assertEq(exchange.getEthAmount(200 ether), 50 ether); // 100 * 200 = 50 * (200 + 200)
    }

    function test_GetTokenAmount() public {
        token.approve(address(exchange), 200 ether);
        exchange.addLiquidity{value: 100 ether}(200 ether);
        assertEq(exchange.getReserve(), 200 ether);
        assertEq(address(exchange).balance, 100 ether);
        //Liquidity Added
        assertEq(exchange.getTokenAmount(100 ether), 100 ether); // 100 * 200 = (100 + 100) * 200
    }



}
