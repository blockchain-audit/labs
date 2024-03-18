// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title Ballot
/// @dev implements voting process along with vote delegation
//what does vote delegation mean?

contract Ballot {

    struct Voter {
        uint weight;
        bool voted;
        address delegate;
        uint vote;
    }

    struct Proposal {
        //we use bytes if we can limit the length 

        bytes32 name;
        uint voteCount;
    }

    address public chairperson;

    mapping(address => Voter) public voters;

    Proposal[] public proposals;

    /// @dev Creat a new ballot to choose one of 'proposalNames'.
    /// @param proposalNames names of 
    
    //what does memory mean?
    //it is used to specify a variable that it should be stored in memory and not in sorage
    //that means that it will only exist during the time that the function is called

    constructor(bytes32[] memory proposalNames) {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;

        for (uint i = 0; i < proposalNames.length; i++){
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }
    /// @dev Give 'voter' the right to on this ballot. may only be called by 'chairperson'
    /// @param voter address of voter

    function giveRightToVote(address voter) public {

        require( msg.sender == chairperson , "Only chairperson can give right to vote");

        require(!voters[voter].voted, "The voter already voted");

        require(voters[voter].weight == 0);

        voters[voter].weight = 1;

    }

    /// @dev Delgate your vote to the voter 'to'
    /// @param to address to which vote is delegated

    //what does delegate mean????

    function delegate(address to) public {
        //what does storage mean?
        // it means that the variable will be stored 
        //in the blockchain specifically in the contract storage 

        Voter storage sender = voters[msg.sender];
        require(!sender.voted, "you already voted");
        require(to !=msg.sender, "Self-delegation is disallowed");
        
        //we use address(0) to check an invalide address or a null address 

        while (voters[to].delegate != address(0)){
            to = voters[to].delegate;

            require(to != msg.sender, "Found loop in delegation.");
        }

        sender.voted = true;
        sender.delegate = to;

        Voter storage delegate_ = voters[to];

        if (delegate_.voted){
            proposals[delegate_.vote].voteCount += sender.weight;
        }
        else{
            delegate_.weight += sender.weight;
        }

    }


    /// @dev Give your vote (including votes delegated to you) to proposal 'proposals[propsal].name'.
    /// @param proposal index of proposal in the proposals array


    function vote(uint proposal) public {
        Voter storage sender = voters[msg.sender];

        require(sender.weight !=0, "Has no right to vote");
        require(!sender.voted, "Already voted.");

        sender.voted = true;
        sender.vote = proposal;

        // add his vote
        proposals[proposal].voteCount += sender.weight;
    }

    /// @dev we calculate the winning proposal 
    /// @return winningProposal_ index of the winning proposal in the proposal array

    function winningProposal() public view returns (uint winningProposal_){
        uint winningVoteCount = 0;
        for (uint p = 0; p<proposals.length; p++){
            if (proposals[p].voteCount > winningVoteCount){
                winningVoteCount = proposals[p].voteCount;
                winningProposal_ = p;
            }
        }
    }



    }

