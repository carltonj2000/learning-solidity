pragma solidity ^0.4.25;

contract ERC20Interface {
    function transferFrom(address from, address to, uint tokens) public returns (bool success);
    function approve(address spender, uint tokens) public returns (bool success);
    function allowance(address tokenOwner, address spender) public view returns (uint remaining);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}