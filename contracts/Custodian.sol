pragma solidity 0.4.18;

import './SafeMath.sol';


/**
 * @title Custodian - Custodian contract
 * @author Matthew Rosendin <matthew@polyledger.com>
 * @dev TODO
 */
contract Custodian {
  using SafeMath for uint;

  /*
   * EVENTS
   */

  event deposited();
  event withdrawed();
  event traded();

  /*
   * CONSTANTS
   */

  address owner;

  /*
   * DATA STRUCTURES
   */

  struct Exchange {
    bytes32 name; // The name of the exchange
  }

  struct Wallet {
    bytes32 identifier; // The account address; represents maximum 256 characters
    bytes32 symbol; // The symbol of the coin represented by this wallet
    Exchange exchange; // The exchange that holds custody of the account
    uint balance; // Not good if Oracle has to constantly update this value
  }

  struct Investor {
    bool active; // Whether the investor is active on Polyledger
    string name; // The investors full name
    bytes32[] wallets; // List of wallet UUIDs
  }

  /*
   * STATE VARIABLES
   */

  // Keyword 'private' means only visible in the current contract
  mapping(address => Investor) private investors;

  /*
   * MODIFIERS
   */

  modifier onlyOwner {
    require(msg.sender == owner);
    _;
  }

  /*
   * METHODS
   */

  /// @dev Instantiates contract that performs basic functions of a custodian
  function Custodian () public {
    owner = msg.sender;
  }

  /**
   * @dev Deposits funds to a wallet
   * @param identifier The UUID of the wallet
   * @param amount The amount to deposit
   */
  function deposit (bytes32 identifier, uint amount) public onlyOwner {}

  /**
   * @dev Withdraws funds from a wallet
   * @param identifier The UUID of the wallet
   * @param amount The amount to withdraw
   */
  function withdraw (bytes32 identifier, uint amount) public onlyOwner {}

  /**
   * @dev Trades an asset for another asset
   * @param baseIdentifier The UUID of the wallet of the asset being sold
   * @param amount The amount to trade
   * @param quoteIdentifier The UUID of the wallet of the asset being bought
   */
  function trade (
    bytes32 baseIdentifier,
    uint amount,
    bytes32 quoteIdentifier
  ) public onlyOwner {}

  /// @dev Fallback function
  function () public {
    revert();
  }
}
