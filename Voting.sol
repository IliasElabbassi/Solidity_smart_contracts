pragma solidity ^0.5.12;

/**
 * @title A tokken called TURTLE
 * @author Ilias El Abbassi, iliaselabbassi@outlook.fr
 **/
 
contract Voting{
    
    enum State {INIT, STARTED, ENDED, PENDING}
    
    struct Candidat {
        uint vote;
        string name;
        bool exist;
    }
    
    struct Voter {
        uint voteBalance;
        bool alreadyVoted;
    }
    
    address public owner;
    mapping(address => Voter) public voters;
    mapping(address => Candidat) public candidats;
    State public state;
    
    constructor() public{
        owner = msg.sender;
        state = State.INIT;
        
    }
    
    modifier ownerOnly() {
        require(msg.sender == owner, "you can't do this action");
        _;
    }
    
    modifier checkVote() {
        require(/**(voters[msg.sender].voteBalance > 0) &&*/ (voters[msg.sender].alreadyVoted == false), "you can't vote");
        _;
    }
    
    function start() public ownerOnly returns(bool sucess) {
        require(state == State.INIT || state == State.ENDED, "you can't start or restart the vote");
        state = State.STARTED;
        
        return true;
    }
    
    function pend() public ownerOnly returns(bool sucess) {
        require(state == State.STARTED, "you can't pend during this period");
        state = State.PENDING;
        
        return true;
    }
    
    function end() public ownerOnly returns(bool sucess) {
        state = State.ENDED;
        
        return true;
    }
    
    function vote(address _candidat) public checkVote returns(bool sucess){
        require(state == State.STARTED, "you can only vote duting the voting period");
        require(voters[msg.sender].alreadyVoted == false, "you can't vote");
        require(candidats[_candidat].exist == true, "you can only vote for real candidats");
        
        candidats[_candidat].vote += 1;
        voters[msg.sender].alreadyVoted = true;
        
        return true;
    }
    
    function vote(address _candidat, uint _value) public checkVote returns(bool sucess){
        require(state == State.STARTED, "you can only vote duting the voting period");
        require(voters[msg.sender].alreadyVoted == false, "you can't vote");
        require(voters[msg.sender].voteBalance >= _value, "not enought vote balance");
        require(candidats[_candidat].exist == true, "you can only vote for real candidats");
        
        candidats[_candidat].vote += _value;
        voters[msg.sender].voteBalance -= _value;
        
        if(voters[msg.sender].voteBalance == 0)
            voters[msg.sender].alreadyVoted = true;
        
        return true;
    }
    
    function addCandidat(address _addr, string memory _name) public ownerOnly returns(bool sucess) {
        require(state == State.INIT, "you can only add a candidat in the initial part");
        
        candidats[_addr].name = _name;
        candidats[_addr].exist = true;
        
        return true;
    }
    
    function giveVote(uint _value, address _addr) public returns(bool sucess) {
        require(state == State.STARTED, "you can only give vote during the voting period");
        require(voters[msg.sender].voteBalance > _value, "you can only give an amount of vote that you have");
        
        voters[msg.sender].voteBalance -= _value;
        voters[_addr].voteBalance += _value;
        voters[_addr].alreadyVoted = false;
    
        return true;
    
    }
    
}
