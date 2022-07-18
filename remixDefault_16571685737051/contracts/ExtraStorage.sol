// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

// Get everything from SimpleStorage Contract like SimpleStorage Contract
// We will inharitance SimpleStorage Contract
// ExtraStorage inharite all functionality of SimpleStorage

contract ExtraStorage is SimpleStorage {
    // HERE WE WANT OUR SimpleStorage store FUNCTION TO ADD 5 WITH PREVIOUS STORE VALUE.
    // OVERRIDE STORE FUNCTION FOR ExtraStorage CONTRACT
    // 2 KEYWORD FOR THAT WE USE,  virtual override
    // TO MAKE A FUNCTION OVERRIDABLE, WE NEED TO USE  "virtual" KEYWORD TO MAIN PARANT FUNCTION
    // NOW USE "override" KEYWORD, WHERE TO OVERRIDE

    function store(uint256 _favoriteNumber) public override {
        favoriteNumber = _favoriteNumber + 5;
    }
}