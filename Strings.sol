pragma solidity ^0.4.25;

library Strings {
    function concat (string _base, string _value) internal pure returns (string) {
        bytes memory _baseBytes = bytes(_base);
        bytes memory _valueBytes = bytes(_value);
        
        string memory _tmpValue = new string(_baseBytes.length + _valueBytes.length);
        bytes memory _newValue = bytes(_tmpValue);
        
        uint i;
        uint j;
        
        for(i = 0; i<_baseBytes.length; i++) {
            _newValue[j++] = _baseBytes[i];
        }
        
        for(i = 0; i<_valueBytes.length; i++) {
            _newValue[j++] = _valueBytes[i];
        }
        
        return string(_newValue);
    }
    
    function strpos(string _base, string _value) internal pure returns (int) {
        bytes memory _baseBytes = bytes(_base);
        bytes memory _valueBytes = bytes(_value);
        
        require(_valueBytes.length == 1, "only one character strpos");

        for(uint i = 0; i<_baseBytes.length; i++) {
            if(_baseBytes[i] == _valueBytes[0]) {
                return int(i);
            }
        }
        
        return -1;        
    }
}
