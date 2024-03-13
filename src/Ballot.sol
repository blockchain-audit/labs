
pragma solidity >=0.6.12 <0.9.0;

contract Ballot{

//voter is chooses
    struct Voter{

        //what is weight?
        uint weight;
        bool voted; //if user already choose
        address delegate;
        uint vote;//index of voted
    }

    struct Proposal{
        bytes32 name;//short name
        uint voteCount;//count of voter of this proposal
    }
    address public chairperson;//main person

    mapping (address => Voter) public voters;

    //arr of proposals
    Proposal[] public proposals;
/*

///@dev create new ballot 
///@param  proposal name
*/
//create new ballot with arr of proposals
//what is memory?
constructor(bytes32[] memory proposalNames){
    chairperson = msg.sender;
    voters[chairperson].weight = 1;
//pass of the arr of names and add the =m to arr of proposal
//with count 0 votes
    for(uint i = 0 ; i < proposalNames.length ; i++){
        proposals.push(Proposal({
            name: proposalNames[i],
            voteCount: 0
        }));
    }
}

///@dev give to votes right to vote in this ballot
//only by chairperson 
///@param voter address of voter

function giveRightToVote(address voter) public {
    //chack if sender this chairperson
    require(msg.sender == chairperson,
    "only chairperson can to voter right to vote");
    //check if voter not vote
    require(!voters[voter].voted,"voter already voted");
    
    require(voters[voter].weight == 0);
    voters[voter].weight = 1;
}


}
