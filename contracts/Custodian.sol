pragma solidity 0.4.18;

import './SafeMath.sol';
import './CoinRegistry.sol';

 /*****************************************************************************
 * @title Custodian - Custodian contract
 * @author Matthew Rosendin <matthew@polyledger.com>
 * @dev A custodian contract that handles financial operations.
 * @dev Entitlements are calculated off-chain.
 *****************************************************************************/
contract Custodian {
  using SafeMath for uint;

  /****************************************************************************
   * EVENTS
   ***************************************************************************/

  event Deposit(uint256 amount);
  event Withdraw(uint256 amount, address recipient);
  event AssetPurchased(bytes32 symbol, uint256 amount);
  event AssetSold(bytes32 symbol, uint256 amount);

  /****************************************************************************
   * CONSTANTS
   ***************************************************************************/

  address owner;    // Polyledger ETH account
  address investor; // Client ETH account
  CoinRegistry registry;

  /****************************************************************************
   * DATA STRUCTURES
   ***************************************************************************/

  struct Position {
    uint256 amount;
  }

  /****************************************************************************
   * STATE VARIABLES
   ***************************************************************************/

  // Mapping of a symbol to position
  mapping(bytes32 => Position) positions;

  /****************************************************************************
   * MODIFIERS
   ***************************************************************************/

  modifier onlyOwner {
    require(msg.sender == owner);
    _;
  }

  modifier onlyInvestor {
    require(msg.sender == investor);
    _;
  }

  modifier onlyInvestorOrOwner {
    require(msg.sender == investor || msg.sender == owner);
    _;
  }

  modifier isRegisteredCoin (bytes32 symbol) {
    require(registry.isRegistered(symbol));
    _;
  }

  /****************************************************************************
   * METHODS
   ***************************************************************************/

  /**
   * @dev Instantiates contract that performs basic functions of a custodian
   * @param _investor The investor
   */
  function Custodian (address _investor, address _registry) public {
    owner = msg.sender;
    investor = _investor;
    registry = CoinRegistry(_registry);
  }

  /**
   * @dev Deposits funds
   */
  function deposit () public payable onlyInvestor {
    Deposit(msg.value); // Polyledger platform will subscribe to this event
  }

  /**
   * @dev Withdraws funds
   * @param amount The amount to withdraw
   */
  function withdraw (uint256 amount) public onlyInvestorOrOwner {
    if (this.balance < amount) revert();
    msg.sender.transfer(amount);
    Withdraw(amount, msg.sender);
  }

  /**
   * @dev Records a purchase of a digital asset
   * @param symbol The symbol of the asset
   * @param amount The amount bought
   */
  function buy (
    bytes32 symbol,
    uint256 amount
  ) public onlyOwner isRegisteredCoin(symbol) {
    positions[symbol].amount += amount;
    AssetPurchased(symbol, amount);
  }

  /**
   * @dev Records a sale of a digital asset
   * @param symbol The symbol of the asset
   * @param amount The amount sold
   */
  function sell (
    bytes32 symbol,
    uint256 amount
  ) public onlyOwner isRegisteredCoin(symbol) {
    positions[symbol].amount -= amount;
    AssetSold(symbol, amount);
  }

  /// @dev Fallback function
  function () public {
    revert();
  }
}
