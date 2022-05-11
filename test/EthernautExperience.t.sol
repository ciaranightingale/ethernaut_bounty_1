// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/EthernautExperience.sol";

contract EthernautExperineceTest is Test {
    error invalidMinter(address _minter);
    error soulbound();

    EthernautExperience public ethernautExperience;
    address minter;
    uint256 amount;
    
    function setUp() public {
        ethernautExperience = new EthernautExperience();
        minter = address(0x1337);
        vm.label(minter, "leet");
        amount = 100 * 10 ** ethernautExperience.decimals();
    }

    function test_setApprovedMinter() public {
        ethernautExperience.setApprovedMinter(minter, true);
        assertEq(ethernautExperience.s_approvedMinters(minter), true);

        ethernautExperience.setApprovedMinter(minter, false);
        assertEq(ethernautExperience.s_approvedMinters(minter), false);
    }

    function test_mint() public {
        ethernautExperience.setApprovedMinter(minter, true);
        vm.prank(minter);
        ethernautExperience.mint(address(this), amount);
        assertEq(ethernautExperience.balanceOf(address(this)), amount);

        vm.expectRevert(abi.encodeWithSignature('invalidMinter(address)', address(this)));
        ethernautExperience.mint(address(this), amount);
    }

    function test_approve() public {
        vm.expectRevert(abi.encodeWithSignature('soulbound()'));
        ethernautExperience.approve(minter, amount);
    }

    function test_transfer() public {
        vm.expectRevert(abi.encodeWithSignature('soulbound()'));
        ethernautExperience.transfer(minter, amount);
    }

    function test_transferFrom() public {
        vm.startPrank(minter);
        vm.expectRevert(abi.encodeWithSignature('soulbound()'));
        ethernautExperience.transferFrom(address(this), address(minter), amount);
        vm.stopPrank();
    }
}
