// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/EthernautExperience.sol";

contract EthernautExperineceTest is Test {
  error InsufficientFunds();
  error InvalidMinter(address _minter);
  error Soulbound();

  event MinterApprovalSet(address indexed _minterAddress, bool _isApproved);
  event Transfer(address indexed from, address indexed to, uint256 value);

  EthernautExperience public ethernautExperience;
  address minter;
  uint256 amount;

  function setUp() public {
    ethernautExperience = new EthernautExperience();
    minter = address(0x1337);
    vm.label(minter, "leet");
    amount = 100 * 10**ethernautExperience.decimals();
  }

  function test_setApprovedMinter() public {
    vm.expectEmit(true, false, false, true);
    emit MinterApprovalSet(minter, true);
    ethernautExperience.setApprovedMinter(minter, true);
    assertEq(ethernautExperience.s_approvedMinters(minter), true);

    vm.expectEmit(true, false, false, true);
    emit MinterApprovalSet(minter, false);
    ethernautExperience.setApprovedMinter(minter, false);
    assertEq(ethernautExperience.s_approvedMinters(minter), false);
  }

  function test_mint() public {
    ethernautExperience.setApprovedMinter(minter, true);
    vm.startPrank(minter);
    vm.expectEmit(true, true, false, true);
    emit Transfer(address(0), address(this), amount);
    ethernautExperience.mint(address(this), amount);
    vm.stopPrank();
    assertEq(ethernautExperience.balanceOf(address(this)), amount);

    vm.expectRevert(
      abi.encodeWithSignature("InvalidMinter(address)", address(this))
    );
    ethernautExperience.mint(address(this), amount);
  }

  function test_burn() public {
    ethernautExperience.setApprovedMinter(minter, true);
    vm.prank(minter);
    ethernautExperience.mint(address(this), amount);
    assertEq(ethernautExperience.balanceOf(address(this)), amount);

    vm.expectEmit(true, true, false, true);
    emit Transfer(address(this), address(0), amount);
    ethernautExperience.burn(amount);
    assertEq(ethernautExperience.balanceOf(address(this)), 0);

    vm.expectRevert(abi.encodeWithSignature("InsufficientFunds()"));
    ethernautExperience.burn(amount);
  }

  function test_approve() public {
    vm.expectRevert(abi.encodeWithSignature("Soulbound()"));
    ethernautExperience.approve(minter, amount);
  }

  function test_transfer() public {
    vm.expectRevert(abi.encodeWithSignature("Soulbound()"));
    ethernautExperience.transfer(minter, amount);
  }

  function test_transferFrom() public {
    vm.startPrank(minter);
    vm.expectRevert(abi.encodeWithSignature("Soulbound()"));
    ethernautExperience.transferFrom(address(this), address(minter), amount);
    vm.stopPrank();
  }
}
