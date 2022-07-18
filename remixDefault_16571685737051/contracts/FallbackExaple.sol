// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FallbackExaple {
    uint256 public result;

    // Whenever we actully call a function or mudule, 
    // its actully happen on  
    // Low level interactions
    // CALLDATA


    // We donnt add function keyword before receive, fallback and constract, 
    // because solidity know this is a speacal function.
    // if we sent ETH here and if there are no data associated with this contract,
    // receive() will trigger than.
    receive() external payable {
        result = 1;
    }

    // if we sent ETH where msg.data is empty than fallback() trigger,
    // Also if there are msg.data but no receive() function than fallback() will trigger than.
    fallback() external payable {
        result = 2;
    }
}

// WHEN RECEICE AND FALLBACK USE
// if (msg.data) {
//     if(receive()) receive()
//     else fallback()
// }
// else fallback() 