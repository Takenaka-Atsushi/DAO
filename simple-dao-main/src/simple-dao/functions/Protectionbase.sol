// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract ProtectionBase {
    modifier protected(uint pid) {
        require(pid != 0, "Invalid pid");
        _;
    }
}
