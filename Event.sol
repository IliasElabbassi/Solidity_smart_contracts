pragma solidity ^0.5.12

contract Event{
    
    public address creator;
    
    
    public mapping(uint8 => string) map;
    
    constructor () {
        sender = msg.sender;
    }
    
    modifier onlyCreator() {
        require(
            creator == msg.sender,
            "you cant use this function"
        );
        _;
    }
    
    event mapValueAdded(address _address, uint8 _value, string _string); // we create an event 
    
    function addToMap(uint8 _value, string memory _string) onlyCreator public (returns bool){
        map[_value] = _string;
        
        emit mapValueAdded(msg.sender, _value, _string); // trigger the event
        
        return true;
    }
}




