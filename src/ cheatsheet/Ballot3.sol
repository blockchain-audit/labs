//Solidity's version
pragma solidity ^0.6.6;

//Definition of a smart contract
contract Ballot {
    //Defines a new data structure named "Voter"
    struct Voter {
        //A variable to store the voter weight
        uint256 weight;
        //A Boolean variable indicating whether the voter voted or not
        bool voted;
        //Stores the address to which the voter delegated his vote
        address delegate;
        //Storing the index of the proposal that the voter voted for
        uint256 vote;
    }
    //Defines another data structure named "Proposal"
    struct Proposal {
        //Storing the offer name as a byte array
        bytes32 name;
        //Storing the number of votes the proposal received
        uint256 voteCount;
    }
    //The address of the address of the head of the council in the Haifa contract
    address public chairperson;
    //A map of the addresses of the voters to the voter objects that will be defined in the "Voter" data structure
    mapping(address => Voter) public voters;
    //An array of election proposals
    Proposal[] public proposals;

    //Constructor:   A function in a smart contract that is only called once when the contract is deployed.
    // It is used to initialize contract state variables and perform any configuration tasks

    //A constructor in the overlap contract that accepts an array of proposal names
    //Gives the head of the council a weight of 1
    //Creates the suggestions based on the names received in the parameter
    constructor(bytes32[] memory proposalNames) public {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;

        for (uint256 i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({name: proposalNames[i], voteCount: 0}));
        }
    }

    function giveRightToVote(address voter) public {
        require(
            msg.sender == chairperson,
            "Only chairperson can give right to vote"
        );
        require(!voters[voter].voted, "The voter already voted");
        require(voters[voter].weight == 0);
        voters[voter].weight = 1;
    }

    function delegate(address to) public {
        Voter storage sender = voters[msg.sender];
        require(!sender.voted, "You already voted.");
        require(to != msg.sender, "Self-delegation is disallowed.");

        while (voters[to].delegate != address(0)) {
            to = voters[to].delegate;

            require(to != msg.sender, "Found loop in delegate");
        }
        sender.voted = true;
        sender.delegate = to;
        Voter storage delegate_ = voters[to];
        if (delegate_.voted) {
            proposals[delegate_.vote].voteCount += sender.weight;
        } else {
            delegate_.weight += sender.weight;
        }
    }

    function vote(uint256 proposal) public {
        Voter storage sender = voters[msg.sender];
        require(sender.weight != 0, "Has no right to vote");
        require(!sender.voted, "Already voted");
        sender.voted = true;
        sender.vote = proposal;

        proposals[proposal].voteCount += sender.weight;
    }

    function winningProposal() public view returns (uint256 winningProposal_) {
        uint256 winningVoteCount = 0;
        for (uint256 p = 0; p < proposals.length; p++) {
            if (proposals[p].voteCount > winningVoteCount) {
                winningVoteCount = proposals[p].voteCount;
                winningProposal_ = p;
            }
        }
    }

    function winnerName() public view returns (bytes32 winnerName_) {
        winnerName_ = proposals[winningProposal()].name;
    }
}
