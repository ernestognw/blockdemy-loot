const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("BlockdemyLoot", function () {
  const setup = async ({ maxSupply = 1000 } = {}) => {
    const [owner] = await ethers.getSigners();
    const BlockdemyLoot = await ethers.getContractFactory("BlockdemyLoot");
    const deployed = await BlockdemyLoot.deploy(maxSupply);

    return {
      owner,
      deployed,
    };
  };

  it("Sets max supply to passed param", async function () {
    const maxSupply = 10000;

    const { deployed } = await setup({ maxSupply });
    const returnedMaxSupply = await deployed.maxSupply();
    expect(maxSupply).to.equal(returnedMaxSupply);
  });
});
