pragma solidity ^0.5.12;
    
contract TurtleToken{
    string public name = "TURTLE";
    string public symbol = "TRL";
    address owner;
    uint256 public TokkenStock;
    
    mapping(address => uint256) public balanceOf;
     
    
    constructor(uint256 stock) public {
        balanceOf[msg.sender] = stock;
        owner = msg.sender;
        TokkenStock = stock;
    }
    
    function sendTokken(address _to, uint _tokkens) public returns (bool sucess){
        require(balanceOf[msg.sender] >= _tokkens);
        
        balanceOf[msg.sender] -= _tokkens;
        balanceOf[_to] += _tokkens;
        
        return true;
    }
    
    function getBalance() public view returns (uint256) {
        return balanceOf[msg.sender];
    }
    
}
