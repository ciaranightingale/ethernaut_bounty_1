// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title EthernautExperience ERC20 Bounty
/// @author Ciara Nightingale
contract EthernautExperience is ERC20, Ownable {

    error invalidMinter(address _minter);
    error soulbound();
    
    /// @notice stores whether an address is an approved minter
    mapping(address => bool) public s_approvedMinters;

    constructor() ERC20("EthernautExperience", "EXP") {}

    /// @notice Sets addresses which are approved to mint
    /// @param _minter Minter address
    /// @param _isApproved Whether address is approved to mint
    function setApprovedMinter(address _minter, bool _isApproved) public onlyOwner {
        s_approvedMinters[_minter] = _isApproved;
    }

    function mint(address to, uint256 amount) public {
        if (!s_approvedMinters[msg.sender]) revert invalidMinter(msg.sender);
        _mint(to, amount);
    }

    /// @notice Overridden to prevent approval
    /// @dev return value can be removed as code unreachable & state mutability can be restricted to pure
    /// however to be fully compliant with ERC20 specification as required by bounty, they must remain
    /// @param /* spender */ spender address (unused)
    /// @param /* amount */ total funds to send (unused)
    function approve(address /* spender */, uint256 /* amount */) public override returns (bool) {
        revert soulbound();
        return false;
    }

    /// @notice Overridden to prevent transfer
    /// @dev return value can be removed as code unreachable & state mutability can be restricted to pure
    /// however to be fully compliant with ERC20 specification as required by bounty, they must remain
    /// @param /* to */ recipient address (unused)
    /// @param /* amount */ total funds to send (unused)
    function transfer(address /* to */, uint256 /* amount */) public override returns (bool) {
        revert soulbound();
        return false;
    }

    /// @notice Overridden to prevent transfer
    /// @dev return value can be removed as code unreachable & state mutability can be restricted to pure
    /// however to be fully compliant with ERC20 specification as required by bounty, they must remain
    /// @param /* from */ sender address (unused)
    /// @param /* to */ recipient address (unused)
    /// @param /* amount */ total funds to send (unused)
    function transferFrom(
        address /* from */,
        address /* to */,
        uint256 /* amount */
    ) public override returns (bool) {
        revert soulbound();
        return false;
    }

}
