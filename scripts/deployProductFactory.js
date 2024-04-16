const { ethers } = require("hardhat");

async function main() {
  const ProductyFactoryContract = await ethers.getContractFactory(
    "ProductFactoryContract"
  );
  const productyFactoryContract = await ProductyFactoryContract.deploy();
  console.log(
    "Product Factory Contract address: ",
    productyFactoryContract.target
  );
}

main().catch((error) => {
  console.log(error);
  process.exitCode = 1;
});
