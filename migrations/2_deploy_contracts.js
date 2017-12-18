const SafeMath = artifacts.require("./SafeMath.sol")
const Custodian = artifacts.require("./Custodian.sol")

module.exports = (deployer) => {
  deployer.deploy(SafeMath)
  deployer.link(SafeMath, Custodian)
  deployer.deploy(Custodian)
}
