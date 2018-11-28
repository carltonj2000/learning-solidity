pragma solidity ^0.4.25;

interface Regulator {
    function checkValue(uint _value) external view returns (bool);
    function loan() external view returns (bool);
}

contract Bank is Regulator {
    uint private value;
    address private owner;
    
    modifier ownerFunc {
        require(owner == msg.sender, "only owner can access account");
        _;
    }
    
    constructor(uint _value) public {
        value = _value;
        owner = msg.sender;
    }
    function deposit(uint _value) ownerFunc public {
        value += _value;
    }
    
    function withdraw(uint _value) ownerFunc public {
        if (this.checkValue(_value)) {
            value -= _value;
        }
    }
    
    function balance() public view returns (uint) {
        return value;
    }
    
    function checkValue(uint _value) external view returns (bool) {
        return value >= _value;
    }
    
}

contract MyFirstContract is Bank(10) {
    string private name;
    uint private age;
    
    function setName(string _name) public {
        name = _name;
    }
    
    function getName() public view returns (string) {
        return name;
    }
    
    function setAge(uint _age) public {
        age = _age;
    }
    
    function getAge() public view returns (uint) {
        return age;
    }
    
    function loan() public view returns(bool) {
        return true;
    }
}