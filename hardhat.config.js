/**
 * @type import('hardhat/config').HardhatUserConfig
 */
 require('dotenv').config(); //all the key value pairs are being made available due to this lib
 require("@nomicfoundation/hardhat-toolbox");
  
 module.exports = {
   solidity: "0.8.17",
   defaultNetwork: 'sepolia',
   paths : {
    sources: "./smart-contracts",
   },
   networks: {
     hardhat: {},
     sepolia: {
         url: process.env.API_URL_KEY,
         accounts: [`0x${process.env.PRIVATE_KEY}`]
     }
   }
 };
