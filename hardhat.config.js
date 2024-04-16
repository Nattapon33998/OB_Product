require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-chai-matchers");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    loaffinity: {
      url: "https://evmrpc1-iot.adldigitalservice.com",
      accounts: [process.env.PRIVATE_KEY],
    },
  },
};
