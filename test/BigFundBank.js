const BigFundBank = artifacts.require("BigFundBank.sol");

contract("BigFundBank", function (accounts) {
  it("Initializes the contract with the correct values.", function () {
    return BigFundBank.deployed()
      .then(function (instance) {
        bankInstance = instance;
        return bankInstance.initialize.call("BigFundBank", 4);
      })
      .then(function () {
        return bankInstance.name();
      })
      .then(function (name) {
        assert.equal(name, "Bank", "Has the bank name.");
      });
  });
});
