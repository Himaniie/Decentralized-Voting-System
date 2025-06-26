const hre = require("hardhat");

async function main() {
  const VotingSystem = await hre.ethers.getContractFactory("VotingSystem");

  // Example candidate names; replace or parameterize if needed
  const candidateNames = ["Alice", "Bob", "Charlie"];
  const contract = await VotingSystem.deploy(candidateNames);

  await contract.deployed();

  console.log(`VotingSystem deployed to: ${contract.address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
