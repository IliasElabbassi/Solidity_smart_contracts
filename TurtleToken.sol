pragma solidity ^0.5.12;

/**
 * @title A token called TURTLE
 * @author Ilias El Abbassi, iliaselabbassi@outlook.fr
 **/
contract TurtleToken{
    
    string public name = "TURTLE";
    string public symbol = "TRL";
    
    address owner;
    uint256 public totalSupply;
    uint8 public decimals = 8;
    
    mapping(address => uint256) public balance;
    mapping(address => mapping(address => uint8)) public authorize;
    
    constructor(uint256 stock) public {
        balance[msg.sender] = stock;
        owner = msg.sender;
        totalSupply = stock;
    }
    
    modifier onlyCreator(){
        require (msg.sender == owner, "you cannot give tokkens");
        _;
    }
    
    modifier authorized(address _from){
        require(authorize[_from][msg.sender] > 0, "you are not authorized to handle the transaction on this address");
        _;
    }
    
    event Transfer(address _spender, address _from, address _to, uint256 _value);
    
    event Approval(address _owner, address _spender, uint8 _value);
    
    function sendTokken(address _to, uint _tokkens) public returns (bool sucess){
        require(balance[msg.sender] >= _tokkens);
        
        // TODO : substract by one the value of authorized number of transaction 
        
        balance[msg.sender] -= _tokkens;
        balance[_to] += _tokkens;
        
        emit Transfer(msg.sender, msg.sender, _to, _tokkens);
        
        return true;
    }
    
    function transferFrom(address _from, address _to, uint256 _value) public authorized(_from) returns (bool success) {
        balance[_from] -= _value;
        balance[_to] += _value;
        
        emit Transfer(msg.sender, _from, _to, _value);
        
        return true;
    }
    
    function approve(address _to, uint8 _value) public returns (bool sucess) {
        authorize[msg.sender][_to] = _value;
        
        emit Approval(msg.sender, _to, _value);
        
        return true;
    }
    
    function giveTokkens(address _to, uint _tokkens) public onlyCreator returns (bool sucess){
        balance[_to] += _tokkens;
        totalSupply -= _tokkens;
        
        return true;
    }
    
    function balanceOf() public view returns (uint256) {
        return balance[msg.sender];
    }
    
    function allowance(address _from) public view returns (uint8) {
        return authorize[_from][msg.sender];
    }
    
}
