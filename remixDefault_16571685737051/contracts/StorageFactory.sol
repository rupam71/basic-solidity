// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
// both import solidity file and existing solidity file should be same

import "./SimpleStorage.sol";

contract StorageFactory {
    // FOR SINGLE INSTANCE
    // SimpleStorage public simpleStorage;

    //FOR ARRAY OF INSTATNCE
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        // FOR SINGLE INSTANCE
        // simpleStorage = new SimpleStorage();

        // FOR ARRAY OF INSTANCE, INITATE ONE INSTANCE AND PUSH IT TO THE ARRAY LATER.
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    // HERE WE WILL INITIATE STORE MODULE FROM NEW INSTANCE OF SimpleStorage
    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        // Always we need to interact any contract 
        // Address of contract, 
        // ABI of contract - Application Binaray Interface : it tell us how to inteact with contract
        // Our all module and function of import file are store in ABI

        // SimpleStorage simpleStorage = SimpleStorage(Address of simpleStorage we want to use);
        // SimpleStorage simpleStorage = SimpleStorage(simpleStorageArray[_simpleStorageIndex]);

        //BECAUSE OF WE ALREADY INITIATE simpleStorageArray, WE CAN DIRECTLY USE THIS
        // SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
        //NOW WE ARE SAVING THE CONTRACT OBJECT AT INDEX SIMPLE STORAGE INDEX TO OUR SIMPLE STORRAGE VARIABLE.
        // OUR ARRAY (simpleStorageArray) KEEP TRACK ADDRESS FOR US, 
        // AND ITS AUTOMATICLY COME WITH ABI HERE.

        // SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
        // simpleStorage.store(_simpleStorageNumber);

        simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
    }

    // // HERE WE WILL VIEW STORE DATA WHICH WE INITIATE PREVIOUSLY
    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256){   
        // SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
        // return simpleStorage.retrieve();

        return simpleStorageArray[_simpleStorageIndex].retrieve();
    }
}