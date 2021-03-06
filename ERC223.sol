pragma solidity ^0.4.25;

contract ERC223Interface {
    function transfer(address to, uint value, bytes data) public returns (bool);
    event Transfer(address indexed from, address indexed to, uint value, bytes indexed data);
}