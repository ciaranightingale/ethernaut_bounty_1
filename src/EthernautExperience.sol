// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@solmate/src/tokens/ERC20.sol";
import "@solmate/src/auth/Owned.sol";

/// @title EthernautExperience ERC20 Bounty
/// @author Ciara Nightingale
contract EthernautExperience is ERC20, Owned {
  /*//////////////////////////////////////////////////////////////
                                 ERRORS
    //////////////////////////////////////////////////////////////*/

  error InvalidMinter(address _minter);
  error Soulbound();
  error InsufficientFunds();

  /*//////////////////////////////////////////////////////////////
                                 EVENTS
    //////////////////////////////////////////////////////////////*/

  event MinterApprovalSet(address indexed _minterAddress, bool _isApproved);
  /*//////////////////////////////////////////////////////////////
                                 STORAGE
    //////////////////////////////////////////////////////////////*/

  /// @notice stores whether an address is an approved minter
  mapping(address => bool) public s_approvedMinters;

  constructor() ERC20("EthernautExperience", "EXP", 18) Owned(msg.sender) {}

  /// @notice Sets addresses which are approved to mint
  /// @param _minter Minter address
  /// @param _isApproved Whether address is approved to mint
  function setApprovedMinter(address _minter, bool _isApproved)
    public
    onlyOwner
  {
    s_approvedMinters[_minter] = _isApproved;
    emit MinterApprovalSet(_minter, _isApproved);
  }

  /// @notice mints the tokens to an address
  /// @param _to recieving address
  /// @param _amount amount of tokens to mint
  function mint(address _to, uint256 _amount) public {
    if (!s_approvedMinters[msg.sender]) revert InvalidMinter(msg.sender);
    _mint(_to, _amount);
  }

  /// @notice Burns unwanted tokens
  /// @param _amount amount of tokens to burn
  function burn(uint256 _amount) public {
    if (balanceOf[msg.sender] < _amount) revert InsufficientFunds();
    _burn(msg.sender, _amount);
  }

  /// @notice Overridden to prevent approval
  /// @dev return value can be removed as code unreachable & state mutability can be restricted to pure
  /// however to be fully compliant with ERC20 specification as required by bounty, they must remain
  /// @param /* spender */ spender address (unused)
  /// @param /* amount */ total funds to send (unused)
  function approve(
    address, /* spender */
    uint256 /* amount */
  ) public override returns (bool) {
    revert Soulbound();
    return false;
  }

  /// @notice Overridden to prevent transfer
  /// @dev return value can be removed as code unreachable & state mutability can be restricted to pure
  /// however to be fully compliant with ERC20 specification as required by bounty, they must remain
  /// @param /* to */ recipient address (unused)
  /// @param /* amount */ total funds to send (unused)
  function transfer(
    address, /* to */
    uint256 /* amount */
  ) public override returns (bool) {
    revert Soulbound();
    return false;
  }

  /// @notice Overridden to prevent transfer
  /// @dev return value can be removed as code unreachable & state mutability can be restricted to pure
  /// however to be fully compliant with ERC20 specification as required by bounty, they must remain
  /// @param /* from */ sender address (unused)
  /// @param /* to */ recipient address (unused)
  /// @param /* amount */ total funds to send (unused)
  function transferFrom(
    address, /* from */
    address, /* to */
    uint256 /* amount */
  ) public override returns (bool) {
    revert Soulbound();
    return false;
  }
}
