// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "../storage/Storage.sol";
import "../CoolVault.sol";

contract DepositFunds {
    CoolVault public coolVault;

    constructor(address _coolVault) {
        coolVault = CoolVault(_coolVault);
    }

    modifier onlyOwner() {
        require(msg.sender == Storage.owner(), "Caller is not the owner");
        _;
    }

    modifier notPaused() {
        require(Storage.dao().state != 6, "DAO is paused");
        _;
    }

    function depositFunds() external onlyOwner notPaused {
        Storage.DAO storage dao = Storage.dao();
        uint amountToDeposit = dao.annualRevenue > 800000 ? dao.annualRevenue - 800000 : 0;
        require(amountToDeposit > 0, "No amount to deposit");

        // Execute the deposit function of CoolVault
        coolVault.deposit(amountToDeposit);

        // Update the DAO's deposited amount
        dao.depositedAmount += amountToDeposit;
    }
}