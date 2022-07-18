// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TestSol {
    int256 public number = 100;

    function increaseNumber () public {
        number = number + 1;
    }

    function decreaseNumber () public {
        number = number - 1;
    }

    function increaseNumberByInput (int256 _number) public {
        number = number + _number;
    }

    function decreaseNumberByInput (int256 _number) public {
        number = number - _number;
    }
}