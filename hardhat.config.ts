import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import * as dotenv from "dotenv";
dotenv.config();

const config: HardhatUserConfig = {
  solidity: "0.8.17",
  // hardhat: {
  //   forking: {
  //     url: process.env.MUMBAI_URL || "",
  //   },
  //   // blockGasLimit: 20000000,
  //   // gas: 12000000,
  //   // allowUnlimitedContractSize: true,
  // },
  networks: {
    hyperspace: {
      chainId: 3141,
      url: "https://api.hyperspace.node.glif.io/rpc/v1",
      //@ts-ignore
      accounts: [process.env.PK],
    },
  },
};

export default config;
