pragma solidity >=0.6.12 <0.9.0;

contract Ballot {
    //voter is chooses
    struct Voter {
        //count of delegate have to this user
        uint256 weight;
        bool voted; //if user already choose
        //possible to give the other voter to choose instead of me
        address delegate;
        uint256 vote; //index of voted
    }

    struct Proposal {
        bytes32 name; //short name
        uint256 voteCount; //count of voter of this proposal
    }

    address public chairperson; //main person

    mapping(address => Voter) public voters;

    //arr of proposals
    Proposal[] public proposals;
    /*

    ///@dev create new ballot 
    ///@param  proposal name
    */
    //create new ballot with arr of proposals
    //what is memory?

    constructor(bytes32[] memory proposalNames) {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;
        //pass of the arr of names and add the =m to arr of proposal
        //with count 0 votes
        for (uint256 i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({name: proposalNames[i], voteCount: 0}));
        }
    }

    ///@dev give to votes right to vote in this ballot
    //only by chairperson
    ///@param voter address of voter

    function giveRightToVote(address voter) public {
        //chack if sender this chairperson
        require(msg.sender == chairperson, "only chairperson can to voter right to vote");
        //check if voter not vote
        require(!voters[voter].voted, "voter already voted");

        require(voters[voter].weight == 0);
        voters[voter].weight = 1;
    }

    function delegate(address to) public {
        //what is storage?
        Voter storage sender = voters[msg.sender];
        //voter not already voterd
        require(!sender.voted);
        //not possible to vote me
        require(to != msg.sender);

        //address(0) this address not valid
        // while nothing delegate
        while (voters[to].delegate != address(0)) {
            to = voters[to].delegate;

            //nothing that delegate will be I
            require(to != msg.sender);
        }

        sender.voted = true;
        sender.delegate = to;
        //what is storage?
        //the delegate of user
        Voter storage delegate_ = voters[to];
        if (delegate_.voted) {
            //if the delegate already choose
            // add to the proposal the number of weight
            proposals[delegate_.vote].voteCount += sender.weight;
        } else {
            //if not voted need to add the weight the number of weight that was on sender
            delegate_.weight += sender.weight;
        }
    }

    ///@dev vote ant this voted instesd of delegeted of this user
    ///@param proposal - index of proposal
    function vote(uint256 proposal) public {
        Voter storage sender = voters[msg.sender];
        // if weight 0 has no right to vote beacuse the chairperson not right your
        require(sender.weight != 0);
        // if use not voted
        require(!sender.voted);
        sender.voted = true;
        sender.vote = proposal;
        //adding to proposal this voter
        // if proposal out the arr this throw and return all changes
        proposals[proposal].voteCount += sender.weight;
    }
    ///@dev function that return the index of winner proposal

    function winningProposal() public view returns (uint256 winningProposal_) {
        uint256 winnimgVoteCount = 0;
        for (uint256 p = 0; p < proposals.length; p++) {
            //if  count that choose thisproposal more big
            if (proposals[p].voteCount > winnimgVoteCount) {
                winnimgVoteCount = proposals[p].voteCount;
                winningProposal_ = p;
            }
        }
    }

    ///@dev return the name of proposal that win
    function winnerName() public view returns (bytes32 winnerName_) {
        winnerName_ = proposals[winningProposal()].name;
    }
}
