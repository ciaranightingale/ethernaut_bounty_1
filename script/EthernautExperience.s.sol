// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/EthernautExperience.sol";

contract MyScript is Script {
  function run() external {
    vm.broadcast();
    EthernautExperience exp = new EthernautExperience();
    assert(exp.owner() == msg.sender);
  }
}
