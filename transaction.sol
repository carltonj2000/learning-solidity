pragma solidity ~0.4.25;

contract Transaction {
    
    event SenderLogger(address);
    event ValueLogger(uint);
    
    address private owner;
    
    modifier isOwner {
        require(owner == msg.sender, "only owner can pay on this contract");
        _;
    }
    
    modifier validValue {
        require(msg.value >= 1 ether, "must send at least 1 ether");
        _;
    }
    
    constructor () public {
        owner = msg.sender;
    }
    
    function () payable isOwner validValue public {
        emit SenderLogger(msg.sender);
        emit ValueLogger(msg.value);
    }
}