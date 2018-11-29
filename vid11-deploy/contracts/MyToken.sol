pragma solidity ^0.4.24;

contract Token {
    string internal _symbol;
    string internal _name;
    uint8 internal _decimals;
    uint internal _totalSupply = 1000;
    mapping (address => uint) internal _balanceOf;
    mapping (address => mapping(address => uint)) internal _allowances;
    
    constructor (string symbol, string name, uint8 decimals, uint totalSupply) public {
        _symbol = symbol;
        _name = name;
        _decimals = decimals;
        _totalSupply = totalSupply;
    }

    function name() public view returns (string) {
        return _name;
    }
    
    function symbol() public view returns (string) {
        return _symbol;
    }
    
    function decimals() public view returns (uint8) {
        return _decimals;
    }
    
    function totalSupply() public view returns (uint) {
        return _totalSupply;
    }
    
}

contract ERC20Interface {
    function transferFrom(address from, address to, uint tokens) public returns (bool success);
    function approve(address spender, uint tokens) public returns (bool success);
    function allowance(address tokenOwner, address spender) public view returns (uint remaining);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}


contract ERC223Interface {
    function transfer(address to, uint value, bytes data) public returns (bool);
    event Transfer(address indexed from, address indexed to, uint value, bytes indexed data);
}

contract ERC223Receiver {
    function tokenFallback(address _from, uint _value, bytes _data) public;
}

library SafeMath {
    /**
    * @dev Multiplies two numbers, reverts on overflow.
    */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "rounding error when multiplying");

        return c;
    }

    /**
    * @dev Integer division of two numbers truncating the quotient, reverts on division by zero.
    */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, "zero denominator in divide");
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
    * @dev Subtracts two numbers, reverts on overflow (i.e. if subtrahend is greater than minuend).
    */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "subtract overflow");
        uint256 c = a - b;

        return c;
    }

    /**
    * @dev Adds two numbers, reverts on overflow.
    */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "add overflow");

        return c;
    }

    /**
    * @dev Divides two numbers and returns the remainder (unsigned integer modulo),
    * reverts when dividing by zero.
    */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0, "modulus base zero not allowed");
        return a % b;
    }
}

contract MyToken is Token("MFT", "My First Token", 18, 1000), ERC20Interface, ERC223Interface {
    
    using SafeMath for uint;

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
            _balanceOf[to].add(tokens);
            _balanceOf[msg.sender].sub(tokens);
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
            _balanceOf[to].add(tokens);
            _balanceOf[msg.sender].sub(tokens);
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
            _balanceOf[from].sub(tokens);
            _balanceOf[to].add(tokens);
            _allowances[from][msg.sender].sub(tokens);
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
