// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//import library
import "./PriceConverter.sol";

contract FundMeWithLibraty {
    using PriceConverter for uint256;

    uint256 public minimumUsd = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    
    function fund() public payable{
        // require(getConvertionRate(msg.value) >= minimumUsd, "Didn't send enough!");

        // here msg.vaule work as first parametre for getConvertionRate() function.
        require(msg.value.getConvertionRate() >= minimumUsd, "Didn't send enough!");

        // if there are 2 parametre in libratyFunction then
        // firstPerametre.functionCall(secondPerametre)

        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function withdraw() public payable{

    }
}