import { ethers } from "hardhat";

async function main() {
  const DS = await ethers.getContractFactory("DuckSouls");
  const ds = await DS.deploy();

  await ds.deployed();

  console.log("DS deployed to:", ds.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
