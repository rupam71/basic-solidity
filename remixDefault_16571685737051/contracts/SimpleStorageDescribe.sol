//SPDX-License-Identifier: MIT
//License optional but compiler give warning. 
//Mit License are least restrivtive License right now.

// Specify a solidity version at the top of .sol file
// This is mandatory

pragma solidity ^0.8.0;
// choose specific version 
// current version 0.8.12 
// more stabe 0.8.7

// ^0.8.7 thats mean any version above this or any newer version is "OK".
// >=0.8.7 < 0.9.0 thats mean any version between 0.8.7 and less than 0.9.0 is "OK".

// contract is like a class in OOP
contract SimpleStorage {
    // All Solidity types : boolean, uint, int, address, bytes
    // uint: unsigned integer. A whole number, not positive or negetive. Just positive.
    // address: is our metamast account address.

    bool hasFavoriteNumber = true;
    uint favoriteNumberTest3 = 123;
    // its special. We specify how many bit we want to allocate to this number.
    uint8 favoriteNumberTest2 = 123;
    // now uint is 8 bit. 
    //DEFAULT IS 256 BIT
    uint256 favoriteNumberTest4 = 123;
    int256 favoriteInt = 5;
    string favoriteNumberText = "Five";
    address myAddress = 0x3691f7e5BB9A64f5abB9A039a8863E1e4b0Dd59f;

    bytes32 favoriteBytes = "cat";
    // String are secretly byte object for text.
    // cat is string but it will convert to bytes object.
    // bytes (2-32) 
    // uint and int are (8-256) increment by 8, because 8 bit is 1 byte

    uint256 public favoriteNumber; 
    // if not initialized then its value is 0
    // uint256 public favoriteNumber; public mean its can be visiable after compiler
    // initialy its all private

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    // view and pure watch only. cannt modify anything in function.
    function retrieve() public view returns(uint256){
        return favoriteNumber;
    }

    // pure fucntion also disallow reading state.
    function add() public pure returns(uint256){
        return (1+1);
    }
    // maybe we need this function for this contract. But cannot modify or read.

    // view and pure use no gas. 
    // we only need gas, if we modify block state. 

    // if we call view or pure in a function that cause gas,
    // then it will cost gas for view and pure too. 
    // Like if we use it in store() function.
 
    struct People {
        uint256 favNumber;
        string name; 
    }
    // Here we made a new type of people who have a favNumer and name. 

    People public person = People({favNumber:88, name:"Pattrik"});

    // ARRAY
    uint256[] favoriteNumberList;
    People[] public people2;
    // they are dynamic array

    //People[3] public people2; its static array can hold 3 person only.

    //MAPPING: another data structure
    // Where a key is mapped to a single value. Like a Dictonary
    mapping(string => uint256) public nameToFavNumber;
    // Here we will get a uint value for every string input.

    function addPerson (string memory _name, uint256 _favoriteNumber) public {
        // uint256 live in memory, so no need to specify memory here
        // but string behind the scene is array of byte. 
        // memory only work on ARRAY, STRUCT and MAPPING
        // we cannot use storage here. 
        // Because SOLIDITY know this is function and this is not store any variable.

        // WAY 1
        // People memory newPerson = People({favNumber:_favoriteNumber, name:_name});

        // WAY 2
        // People memory newPerson = People(_favoriteNumber, _name);
        // no object chaining, just put it in order of struct Peole made.

        // people2.push(newPerson)
        people2.push(People(_favoriteNumber, _name));
        
        // Already add to an array. Now add its to our mapping
        nameToFavNumber[_name] = _favoriteNumber ;
    }

    // EVM store data in 6 location
    // Stack, Memory, Storage, Calldata, code, Logs
    // calldata and memory are temporary. Previously memory only call when function execute. 
    // calldata can not be modified in function but memory can be modified.
    // Storage var can exist outside function executing. Its acualy our all global variable. 
    // we can not call Stack, code, Logs

}




