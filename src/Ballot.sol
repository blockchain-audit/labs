pragma solidity >=0.7.0 <0.9.0;

contract Ballot {
    //structs to define the contract
    struct Voter {
        uint weight; //
        bool voted;  //
        address delegate; //
        uint vote;   // 
    }
    struct Proposal {
        
        bytes32 name;   // 
        uint voteCount; // 
    }
    //the chair person address
     address public chairperson;
//napping of addresses to voter
    mapping(address => Voter) public voters;
//array of proposals
    Proposal[] public proposals;
//constractor that initializes the chairperson to 1 and the proposals array 
    constructor(bytes32[] memory proposalNames) {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;

        for (uint i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({
                name:proposalName[i],
                voteCount:0
            }));
        }

}
//allow the chairperson to give vote to specific address
//and check if he already voted
function giveRightToVote(address voter) public {
        require(
            msg.sender == chairperson,
            "Only chairperson can give right to vote."
        );
        require(
            !voters[voter].voted,
            "The voter already voted."
        );
        require(voters[voter].weight == 0);
        voters[voter].weight = 1;
    }

//allows a voter to delegate his vote to anothe address
function delegate(address to) public {
    //put in the parameter the voter struct 
    Voter storage sender = voters[msg.sender];
    //to ensure that the sender not already voted
    require(!sender.voted,"You already voted");
    require(to != msg.sender,"Self-delegation is disallowed.");

    while (voters[to].delegate != address(0)) 
    {
        to = voters[to].delegate;

        require(to !=msg.sender, "Found loop in delegation");
    }
    //after finding the address (to) the func update the status and delegate
    //and return the struct 
     sender.voted = true;
    sender.delegate = to;
    Voter storage delegate_ = voters[to];
     if (delegate_.voted) {
         proposals[delegate_.vote].voteCount += sender.weight;
     }
     else
     {
        delegate_.weight += sender.weight;
     }
}
//allow to the voter to vote specific proposal 
function vote(uint Proposal) public {
    Voter storage sender = voters[msg.sender];
    //check that the sender can vote
    require(sender.weight !=0, "Has no right to vote");
    require(!sender.voted, "Already voted");
//update the status
    sender.voted = true;
    sender.vote = Proposal;
//update the number of votes to proposal
    proposals[Proposal].voteCount += sender.weight;
}
//iterates on all the proposals compare their vote snd return the max
function winningProposal() public view returns (uint winningProposal_){
    uint winningVoteCount = 0;
    //loop
        for (uint p = 0; p < proposals.length; p++) {
            if (proposals[p].voteCount > winningVoteCount) {
                winningVoteCount = proposals[p].voteCount;
                winningProposal_ = p;
            }
        }
}

//return the name of the winning proposonal 
function winnerName() public view returns (bytes32 winnerName_)
{
    winnerName_ = proposals[winningProposal()].name;
}
}
