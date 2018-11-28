pragma solidity ^0.4.25;

interface Regulator {
    function checkValue(uint _value) external view returns (bool);
    function loan() external view returns (bool);
}

contract Bank is Regulator {
    uint private value;
    
    constructor(uint _value) public {
        value = _value;
    }
    function deposit(uint _value) public {
        value += _value;
    }
    
    function withdraw(uint _value) public {
        if (this.checkValue(_value)) {
            value -= _value;
        }
    }
    
    function balance() public view returns (uint) {
        return value;
    }
    
    function checkValue(uint _value) external view returns (bool) {
        return _value >= value;
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