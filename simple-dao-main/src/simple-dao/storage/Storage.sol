// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

library Storage {
    struct DAO {
        uint id;
        uint state;
        uint annualRevenue;
        uint depositedAmount;
        address owner;
    }

    function dao() internal pure returns (DAO storage ds) {
        bytes32 position = keccak256("dao.storage");
        assembly {
            ds.slot := position
        }
    }

    function owner() internal pure returns (address) {
        return dao().owner;
    }

    function isOwner(address account) internal view returns (bool) {
        return account == owner();
    }
}

