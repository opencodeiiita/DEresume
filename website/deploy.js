const { ethers } = require("hardhat");
async function main() {

   const pv = await ethers.getContractFactory('MetaMask);

   const hw = await pv.deploy();

   console.log('SBT Contract Deployed to:', hw.address);
}

main().then(() => process.exit(0))
.catch(error => {
 console.error(error);
 process.exit(1);
});
