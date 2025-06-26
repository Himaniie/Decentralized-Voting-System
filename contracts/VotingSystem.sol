// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract VotingSystem {
    struct Candidate {
        string name;
        uint voteCount;
    }

    address public admin;
    bool public votingActive;

    mapping(address => bool) public hasVoted;
    Candidate[] public candidates;

    constructor(string[] memory candidateNames) {
        admin = msg.sender;
        for (uint i = 0; i < candidateNames.length; i++) {
            candidates.push(Candidate(candidateNames[i], 0));
        }
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this");
        _;
    }

    modifier whenVotingActive() {
        require(votingActive, "Voting is not active");
        _;
    }

    function startVoting() public onlyAdmin {
        votingActive = true;
    }

    function endVoting() public onlyAdmin {
        votingActive = false;
    }

    function vote(uint candidateIndex) public whenVotingActive {
        require(!hasVoted[msg.sender], "You have already voted");
        require(candidateIndex < candidates.length, "Invalid candidate");

        candidates[candidateIndex].voteCount++;
        hasVoted[msg.sender] = true;
    }

    function getCandidates() public view returns (Candidate[] memory) {
        return candidates;
    }

    function getWinner() public view returns (string memory winnerName, uint highestVotes) {
        require(!votingActive, "Voting is still active");

        uint maxVotes = 0;
        uint winnerIndex = 0;

        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > maxVotes) {
                maxVotes = candidates[i].voteCount;
                winnerIndex = i;
            }
        }

        return (candidates[winnerIndex].name, candidates[winnerIndex].voteCount);
    }
}
