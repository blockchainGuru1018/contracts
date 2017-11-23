const SafeMath = artifacts.require("./SafeMath.sol")
const Placeholder = artifacts.require("./Placeholder.sol")

module.exports = (deployer) => {
  deployer.deploy(SafeMath)
  deployer.link(SafeMath, Placeholder)
  deployer.deploy(Placeholder)
}
