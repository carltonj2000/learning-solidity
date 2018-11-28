pragma solidity ^0.4.25;

contract DataTypes {    
    bool myBool = false;
    int8 myInt8 = -128;
    uint8 myUint8 = 255;

    string myString;
    uint8[] myStringArr;
    
    function myFunc(string s) public {
        myString = s;
    }
    
    byte myValue;
    bytes1 myBytes1;
    bytes12 myBytes12;
        
    fixed myFixed;
    // fixed256x8 myFixed256x8 = -128.0; // not supported crashes the compiler
    // ufixed256x8 myUfixed256x8 = 128.0; // not supported crashes the compiler

    enum Action {ADD, REMOVE, UPDATE}
    Action myAction = Action.ADD;
    
    address myAddress;
    
    function assignAddress() public {
        myAddress = msg.sender;
        myAddress.balance;
        myAddress.transfer(10);
    }
    
    uint[] myIntArr = [1,2,3];
    
    function arrFunc() public {
        myIntArr.push(1);
        myIntArr.length;
        myIntArr[0];
    }
    
    uint[10] myFixedArr;
    
    struct Account {
        uint balance;
        uint dailyLimit;
    }
    
    Account myAccount;
    
    function structFunc () public {
        myAccount.balance = 100;
        myAccount.dailyLimit;
    }
    
    mapping (address => Account) _accounts;
    
    function () public payable  {
        _accounts[msg.sender].balance += msg.value;
    }
    
    function getBalance() public view returns (uint) {
        return _accounts[msg.sender].balance;
    }
}