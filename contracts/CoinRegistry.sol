pragma solidity 0.4.18;

import './SafeMath.sol';


/******************************************************************************
 * @title CoinRegistry - CoinRegistry contract
 * @author Matthew Rosendin <matthew@polyledger.com>
 * @dev Registers supported coins
 *****************************************************************************/
contract CoinRegistry {
  using SafeMath for uint;

  /****************************************************************************
   * EVENTS
   ***************************************************************************/

  event coinAdded(bytes32 symbol);

  /****************************************************************************
   * CONSTANTS
   ***************************************************************************/

  address owner;

  /****************************************************************************
   * STATE VARIABLES
   ***************************************************************************/

  mapping(bytes32 => bool) coins;

  /****************************************************************************
   * MODIFIERS
   ***************************************************************************/

  modifier onlyOwner {
    require(msg.sender == owner);
    _;
  }

  /****************************************************************************
   * METHODS
   ***************************************************************************/

  /// @dev Instantiates contract that performs basic functions of a wallet
  function CoinRegistry () public {
    owner = msg.sender;
  }

  /**
   * @dev Registers a new coin
   * @param symbol The symbol of the coin
   */
  function register (bytes32 symbol) public onlyOwner {
    coins[symbol] = true;
    coinAdded(symbol);
  }

  /**
   * @dev Checks if a coin is registered
   * @param symbol The symbol of the coin to check
   */
  function isRegistered (bytes32 symbol) public constant returns (bool) {
    return coins[symbol];
  }

  /// @dev Fallback function
  function () public {
    revert();
  }
}
