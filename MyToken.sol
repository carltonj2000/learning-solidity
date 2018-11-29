pragma solidity ^0.4.25;

import "browser/Token.sol";
import "browser/ERC20.sol";
import "browser/ERC223.sol";
import "browser/ERC223ReceivingContract.sol";

contract MyToken is Token("MFT", "My First Token", 18, 1000), ERC20Interface, ERC223Interface {
    
    constructor () public {
        _balanceOf[msg.sender] == _totalSupply;
    }

    function balanceOf(address tokenOwner) public view returns (uint balance) {
        return _balanceOf[tokenOwner];
    }
    function transfer(address to, uint tokens) public returns (bool success) {
        if (
            tokens > 0 &&
            tokens <= _balanceOf[msg.sender] &&
            !isContract(to)
        ) {
            _balanceOf[to] += tokens;
            _balanceOf[msg.sender] -= tokens;
            return true;
        }
        emit Transfer(msg.sender, to, tokens, "");
        return false;
    }
    function transfer(address to, uint tokens, bytes data) public returns (bool success) {
        if (
            tokens > 0 &&
            tokens <= _balanceOf[msg.sender] &&
            isContract(to)
        ) {
            _balanceOf[to] += tokens;
            _balanceOf[msg.sender] -= tokens;
            ERC223Receiver _contract = ERC223Receiver(to);
            _contract.tokenFallback(msg.sender, tokens, data);
            emit Transfer(msg.sender, to, tokens, data);
            return true;
        }
        return false;        
    }
    function isContract(address addr) private view returns (bool) {
        uint codeSize;
        assembly {
            codeSize := extcodesize(addr)
        }
        return codeSize > 0;
    }
    
    function transferFrom(address from, address to, uint tokens) public returns (bool success) {
        if (
            tokens > 0 && 
            _allowances[from][msg.sender] >= tokens &&
            _balanceOf[from] >= tokens
        ) {
            _balanceOf[from] -= tokens;
            _balanceOf[to] += tokens;
            _allowances[from][msg.sender] -= tokens;
            emit Transfer(from, to, tokens, "");
            return true;            
        }
        return false;
    }

    function approve(address spender, uint tokens) public returns (bool success) {
        _allowances[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }

    function allowance(address tokenOwner, address spender) public constant returns (uint remaining) {
        return _allowances[tokenOwner][spender];
    }
}
