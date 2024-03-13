pragma solidity ^0.8.20;
contract Ballot {
    //this is aobject
    struct Voter {
        uint weight;
        bool voted;
        address delegate;
        uint vote;
    }

    struct Proposal {
        bytes32 name;
        uint voteCount;
    }

    address public chairperson;

    mapping(address => Voter) public voters;

    Proposal [] public proposals;

    constructor(bytes32[] memory proposalNames) {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;

        for(uint i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));

        }
    }

    function giveRightToVote(address voter) public {
        require(
            msg.sender == chairperson,
            "only chairperson can giv right to voted."
        );

        require(!voters[voter].voted, "the voter already voted.");

        require(voters[voter].weight == 0);
        voters[voter].weight = 1;
    }

    function delegat(address to) public {
        Voter storage sender = voters[msg.sender];
        require(!sender.voted, "you already voted.");
        require(to != msg.sender, "self-delgation is disallowd.");

        while(voters[to].delegate != address(0)) {
            to = voters[to].delegate;
            require(to != msg.sender, "Found loopin delegation.");
        }
        sender.voted = true;
        sender.delegate = to;
        Voter storage delegate_ = voters[to];
        if(delegate_.voted) {
            proposals[delegate_.vote].voteCount += sender.weight;

        }
        else {
            delegate_.weight += sender.weight;
        }
    }
    function vote(uint proposal) public {
        Voter storage sender = voters[msg.sender];
        require(sender.weight != 0,"Has no right to vote");
        require(!sender.voted, "Alreadyvoted.");
        sender.voted = true;
        sender.vote = proposal;
        proposals[proposal].voteCount += sender.weight;
    }

    function winningProposal() public view returns (uint winningProposal_) {
        uint winnindVoteCount = 0;
        for(uint p = 0; p < proposals.length; p++) {
            if(proposals[p].voteCount > winnindVoteCount) {
                winnindVoteCount = proposals[p].voteCount;
                winningProposal_ = p;
            }

        }
    }

    function winnerName() public view returns (bytes32 winnerName_) {
        winnerName_ = proposals[winningProposal()].name;
    }
}
