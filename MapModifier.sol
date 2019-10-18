pragma solidity ^0.5.12;

contract MapModifier{
    
    uint8 nonce = 0;
    address public creator;
    mapping(uint8 => string) public map; // map[uint] will give the string assoiciated to it
    
    modifier onlyCreator() {
        require(
            msg.sender == creator,
            "you cant use this function"
        );
        _; // will execute the function that this modifier is attached to here
    }
    
    constructor () public {
        creator = msg.sender;
    }
    
    function addToMap(uint8  _value, string memory _string) onlyCreator public{
        map[_value] = _string;
    }
    
    function onlyCreatorTest(string memory _string) onlyCreator public{
        require(false, _string);
        nonce++;
    }
}
