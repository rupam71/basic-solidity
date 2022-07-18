// Get funds from users
// Withdreaw funds
// set a minimum funding value in USD

        // Every transection we send have this field
        // Nonce: transection count for the account
        // Gas Price: price per unit of gas (in wei)
        // Gas Lilmit: max gas that this transection can use
        // To: address that the trancsection is sent to
        // Value: amount of  wei to send
        // Data: what to send to the To address
        // v,r,s : components of transection signature

// Smart contract can hold funds just like how wallets can

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import from github/link
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
// @chainlink/contracts means npm package called @chainlink/contracts

// create custom error, so that we will not use required and save gas
error NotOwner();

contract FundMe {
    // constant used, so that it cannt be modified. Now minimumUsd  will not take storege spot. Whilch is gas efficient.
    uint256 public constant minimumUsd = 50 * 1e18; // need to add 18 decimal point

    // here we will store all funders address
    address[] public funders;
    // How much money each sender actully send
    mapping(address => uint256) public addressToAmountFunded;

    // variable which set only one time, but out of its declaration scope can use immutable keyword.
    // As constant, its also gas efficient. Convention is used i and underscore before. Like immutable i_owner
    address public immutable i_owner;

    //Person who collecting the fund only call he withdraw the function
    // constructor function called when contract deploy
    constructor() {
      // constructor set who is owner here
      i_owner = msg.sender;
    }
    
    function fund() public payable{
        // want to be able set a minimum fund amount in USD
        // 1. How do we send ETH to this contract

        // payable keyword make our fund func red as opposed to orange.

        // require(msg.value > 1e18, "Didn't send enough!"); //1e18 == 1*10^18 = 1000000000000000000
        // require mean must, here minimum 1 etr, or revert with this error string

        // require(msg.value > minimumUsd, "Didn't send enough!");
        require(getConvertionRate(msg.value) >= minimumUsd, "Didn't send enough!");
        funders.push(msg.sender); // sender and value are global varable. It will always work.
        // sender is sender address, (wallet address)
        addressToAmountFunded[msg.sender] = msg.value;
    }

    // Since we're not modifying any state with this get price function, 
    // we can make this view and day it returns uint256
    function getPrice () public view returns (uint256) {
        // To call price we need 2 things
        // ABI :: AggregatorV3Interface
        // Address :: docs.chain.link => Ethereum Data Feed => Rinkby => ETH / USD => 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);

        // Here one latestRoundData() module retrun multiple data variable. So we distructure many variable like that.
        // (uint80 roundId, int price, uint startedAt, uint timeStamp, uint80 answeredInRound) = priceFeed.latestRoundData()

        // If we want only one variable to return 
        (, int price,,,) = priceFeed.latestRoundData();
        // this is price of ETH in terms of USD
        // 3000 = 3000.00000000, solidity have no dacimal value. So last 8 digit are decimal value
        // but msg.value has 18 decimal place 
        // msg.value and price are different unit: price int256, msg.value uint256
        // To match up we will convert price to uint256: Its called type casting
        return uint256(price * 1e10); 
        // now it has total 18 decimal place. 8 from price and 10 add to match 18 decimal place of msg.value

    }

    function getVersion () public view returns (uint256) {
      AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
      return priceFeed.version();
    }

    function getConvertionRate(uint256 ethAmount) public view returns (uint256) {
            uint256 ethPrice = getPrice();
            uint256 ethAmountInUsd = (ethPrice*ethAmount)/1e18;
            return ethAmountInUsd;
    }
  
    function withdraw() public onlyOwner {
      // if it pass then, withdraw function execute, otherwise revert.
      // require(msg.sender == owner, "Sender is not owner" );

      // WE DONNT NEED THIS, BECAUSE WE ALREADY DECLAYER A MODIFIER CALL onlyOwner
      // Here first onlyOwner modifier call, then res of the code

      // we will use solidity for loop here
      for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++ ){
        address funder = funders[funderIndex];
        addressToAmountFunded[funder] = 0;
      }

      // reset the array
      funders = new address [](0) ;
      // funders now with array of address with 0 object/array element in it.

      //actully withdraw the funds
      // 3 way to do that (Transfar, Send, Call)

      // TRANSFAR
      // at first msg.sender was a address type. we need to convert it to a payalbe type.
      // msg.sender = address
      // payable(msg.sender) = payable address
         // payable(msg.sender).transfer(address(this).balance)
      // here this is refer to whole contract
      // if transfer method use more then 2300 gas, it will failed and revert transection.

      // SEND
      // payable(msg.sender).send(address(this).balance)
      // if it failed or used more than 2300 gas, it will not revet but send an bool type fase
        // bool sendSuccess = payable(msg.sender).send(address(this).balance)
        // require(sendSuccess,  "Send failed"); // if sendSuccess failed, throw an error

      // CALL
      // its lower lavel command we use but most effecent and powerfull.
      // RECOMMNADED WAY TO SEND AND RECIVE ETH OR BTC TOKEN FOR NOW.
      
      // (bool callSuccess, bytes memory dataReturned) = payable(msg.sender).call{value: address(this).balance}("")
      // here we call an empty string. Because here we not call anyting. If we call any function we will call it here.
      // {value: address(this).balance} this is out transection
      // here call return 2 variable. callSuccess is this call status bool
      // dataReturned is this data of this call. Bytes are array so we need memory.

      (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
      require(callSuccess,  "Call failed"); // if callSuccess failed, throw an error
    }

    // create a MODIFIER
    // Modifier is gonna be a keyword, that we can add right in the function declaration 
    // to modify function with that functionallity. 
    modifier onlyOwner {
      // require(msg.sender == i_owner, "Sender is not owner" );
      // _; // its mean doint the rest of the code
      // here require run first then rest of the code. because _ situated in down here. 

      //  _; 
      // require(msg.sender == owner, "Sender is not owner" );
      // here rest of the code run first than require run. because _ situated in the up here. 

      // Here we will use custom error insted of  required. So that we can save gas.
      if(msg.sender != i_owner) { revert NotOwner(); }
      _;
    }

    // What happens if someone sends this contract ETH without calling the fund function.
    // 2 special function in solidity. 
    // 1. receive()
    // 2. fallback()

    // if someone accidently send money without call fund(), we can handle it by receive() function.
    receive() external payable {
      fund();
    }

    fallback() external payable {
      fund();
    }
}

// Chainlink keeper is like a timer of blockchain. 
// It hit a certain time, or the price hit a certain number. 