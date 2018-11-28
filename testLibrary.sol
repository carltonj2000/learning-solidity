pragma solidity ~0.4.25;

import 'browser/library.sol';

contract TestLibrary {
    using IntExtended for uint;
    
    function testIncrement(uint _base) public pure returns (uint) {
        return _base.increment();
    }
    function testDecrement(uint _base) public pure returns (uint) {
        return _base.increment();
    }
    function testIncrementByValue(uint _base, uint _value) public pure returns (uint) {
        return _base.incrementByValue(_value);
    }
    function testDecrement(uint _base, uint _value) public pure returns (uint) {
        return _base.decrementByValue(_value);
    }
    
    
}