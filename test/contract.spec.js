const Custodian = artifacts.require('Custodian')

contract('Custodian', accounts => {
  it('should pass', async () => {
    let instance = await Custodian.deployed()
    assert.equal(true, true)
  })
})
