pragma solidity ^0.4.25;

import "browser/ERC20.sol";

contract MyToken is ERC20Interface {
    string public constant symbol = "MFT";
    string public constant name = "My First Token";
    uint8 public constant decimals = 18;
    
    uint private constant __totalSupply = 1000;
    mapping (address => uint) private __balanceOf;
    mapping (address => mapping(address => uint)) private __allowances;
    
    constructor () public {
        __balanceOf[msg.sender] == __totalSupply;
    }
    function totalSupply() public constant returns (uint) {
        return __totalSupply;
    }
    
    function balanceOf(address tokenOwner) public constant returns (uint balance) {
        return __balanceOf[tokenOwner];
    }
    function transfer(address to, uint tokens) public returns (bool success) {
        if (tokens > 0 && tokens <= balanceOf(msg.sender)) {
            __balanceOf[to] += tokens;
            __balanceOf[msg.sender] -= tokens;
            return true;
        }
        return false;
    }

    function transferFrom(address from, address to, uint tokens) public returns (bool success) {
        if (tokens <= 0 && tokens > __allowances[from][msg.sender]) return false;
        __balanceOf[from] -= tokens;
        __balanceOf[to] += tokens;
        return true;
    }

    function approve(address spender, uint tokens) public returns (bool success) {
        if (tokens <= balanceOf(msg.sender)) return false;
        __allowances[msg.sender][spender] = tokens;
        return true;
    }

    function allowance(address tokenOwner, address spender) public constant returns (uint remaining) {
        return __allowances[tokenOwner][spender];
    }


    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);    
}
