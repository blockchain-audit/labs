// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/// @title Ballot
contract Ballot {

    // pointer
    struct Voter {
        // weight is accumulated by delegation
        uint256 weight;
        // voted = true - that person already voted
        bool voted;
        // person delegated to
        address delegate;
        // index of the voted proposal
        uint256 vote;
    }

    // idea
    struct Proposal {
        // short name
        bytes32 name;
        // number of accumulated votes
        uint256 voteCount;
    }

    // main user
    address public chairperson;

    mapping(address => Voter) public voters;

    // array of ideas
    Proposal[] public proposals;

    // @dev Create a new ballot to choose one of 'proposalNames'
    // @param proposalNames - names of proposals - ideas
    // what is memory?
    // short term memory
    constructor(bytes32[] memory proposalNames) {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;

        for (uint256 i = 0; i < proposalNames.length; i++) {
            // add idea to the end of the array of ideas
            proposals.push(Proposal({name: proposalNames[i], voteCount: 0}));
        }
    }

    /// @dev give 'voter' the right to vote on this ballot
    /// @param voter - address of voter
    function giveRightToVote(address voter) public {
        // only the chairperson can give the right
        require(
            msg.sender == chairperson,
            "Only chairperson can give right to vote."
        );

        // only voter that didn't vote will be able to vote
        require(!voters[voter].voted, "The voter already voted.");

        // only voter that didn't vote will be able to vote
        require(voters[voter].weight == 0);

        voters[voter].weight = 1;
    }

    /// @dev transferring the right to the voter 'to'
    /// @param to - the address to transer the right
    function delegate(address to) public {
        // what is storage?
        // storage - long term memory
        Voter storage sender = voters[msg.sender];

        // only voter that didn't vote will be able to vote
        require(!sender.voted, "You already voted.");

        // It is not possible to transfer the right back to the current voter
        require(to != msg.sender, "Self-delegation is disallowed.");

        while (voters[to].delegate != address(0)) {
            to = voters[to].delegate;

            // preventing an infinite loop
            // it is not possible to return the right to the current voter
            require(to != msg.sender, "Found loop in delegation.");
        }

        // this sender already voted
        sender.voted = true;
        // the address of the person who right has been transferred to him
        sender.delegate = to;
        // the person who right has been transferred to him
        Voter storage delegate_ = voters[to];

        if (delegate_.voted) {
            // if the delegate already voted
            // add the weight to the 'voteCount' - number of votes
            proposals[delegate_.vote].voteCount += sender.weight;
        } else {
            // if the delegate did not vote yet
            // add the weight to her weight
            delegate_.weight += sender.weight;
        }
    }

    /// @dev give your vote to proposal
    /// @param proposal - index of proposal in the proposals array
    function vote(uint256 proposal) public {
        Voter storage sender = voters[msg.sender];
        require(sender.weight != 0, "Has no right to vote");
        // only voter that didn't vote will be able to vote
        require(!sender.voted, "Already voted.");

        sender.voted = true;
        sender.vote = proposal;

        // if the proposal is out of the range of the array
        // this will throw automatically and revert all changes
        proposals[proposal].voteCount += sender.weight;
    }

    /// @dev computes the winning proposal taking all previous votes into account
    /// @return winningProposal_ - index of winning proposal in the proposals array
    function winningProposal() public view returns (uint256 winningProposal_) {
        uint256 winningVoteCount = 0;

        for (uint p = 0; p < proposals.length; p++) 
        {
            // find the maximum - the winners
            if (proposals[p].voteCount > winningVoteCount) {
                winningVoteCount = proposals[p].voteCount;
                winningProposal_ = p;
            }
        }
    }

    /// @dev calls winningProposal function to get the index of the winner and return the name
    /// @return winnerName_ - the name of the winner
    function winnerName() public view returns (bytes32 winnerName_) {
        winnerName_ = proposals[winningProposal()].name;
    }

}
