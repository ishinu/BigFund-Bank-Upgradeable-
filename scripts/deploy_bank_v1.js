const BigFundBank = artifacts.require("BigFundBank.sol");

module.exports = function (deployer) {
  deployer.deploy(BigFundBank);
};
