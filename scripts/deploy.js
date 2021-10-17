async function main() {
  const BlockdemyLoot = await hre.ethers.getContractFactory("BlockdemyLoot");
  const blockdemyLoot = await BlockdemyLoot.deploy(2048);

  await blockdemyLoot.deployed();

  console.log("Blockdemy Loot deployed to:", blockdemyLoot.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
