# Tier One Contract where shares are distributed equally

## State Variables

    address payable employee_one;

Ethereum Data can be stored in 3 different locations:

**1- Storage:** 

* areas located inside each account that is used to store contract **State Variables**
* Storage is assigned during the process of creating a contract
* You can only change it with `send transaction`


**2- Memory:** 

* Linear and holds temporary values.
* Only exist in the calling `function` and gets erased between calls.
* Used in this contract to hold value of string to reduce cost and gas.

**3- Stack:** 

* Where computation happens
* Used to store **Local Variables**

**LOGS**

* Holds data in anindexed structure with mapping that reaches block level.
* Contracts will not access the data stored in logs after it's creation.

`address` 

solidity a statically typed language, which means that the type of each variable (state and local) needs to be specified at compile-time. You can read more about [Types in Solidity](https://docs.soliditylang.org/en/v0.4.24/types.html#:~:text=Solidity%20is%20a%20statically%20typed,combined%20to%20form%20complex%20types.)

holds a 20-byte value (size of an Ethereum address).

`address payable` 

is the same as address, but have `transfer` and `send` members. And can receive Ether, while simple address can't.

You can change from `address payable` to `address` but not vice versa.




## Constructor

    
    constructor(address payable _one, address payable _two, address payable _three) public {
        employee_one = _one;
        employee_two = _two;
        employee_three = _three;
    }

* Gets executed once in the contract life time when deployed.
* Force you to manually input parameters `address payable _one, address payable _two, address payable _three`  before deploying the contract; otherwise Error will be displayed, as follows:

    "Error encoding arguments: Error: invalid address (argument="address", value="", code=INVALID_ARGUMENT, version=address/5.0.5)"

* `public` sets the function visbility to public, which allows anyone to get the value of the variable.
* allows you to pass state variables in the constructor `employee_one = _one` as an argument underscored instead of hard coding employee_one address inside the contract, like in this alternative code lines:

        pragma solidity ^0.5.0;
        contract TierOne {
            address payable employee_One = 0x6cB253616930A3D4214B0350a49BABfC2B568413;
            address payable employee_Two = 0x6cB253616930A3D4214B0350a49BABfC2B568414;
            address payable employee_three = 0x6cB253616930A3D4214B0350a49BABfC2B568415;





### Visibility

1- PUBLIC : the variable value can be accessed from outside the contract and other functions
2- EXTERNAL : only external functions can get the value of the a LOCAL VARIABLE.
3- INTERNAL : only functions in this contract and related contracts can get the variable value.
4- PRIVATE : access is limited to functions from this contract.


## Functions

The basic syntax is as follows:

    function function-name(parameter-list) scope returns() {
        //statements
    }

    function balance() public view returns(uint) {
        return address(this).balance;


`function` defined the function in solidity just like we do in varaibles

`balance` is the function name.

`public view returns(uint)` setting function visibility to public that will only view the result of possitive integer (unsigned integers of variuos sizes) which is the profit shares distribution.

`return address(this).balance` that will return the balance of this contract. using `(this)` because the contract address is unknown till after deployment takes place. And Advantage of using `address payable` is `.balance` to get the balance unlike `address` only.


    function deposit() public payable {
        // Split `msg.value` into three
        uint amount = msg.value / 3; 

        //Transfer the amount to each employee
        employee_one.transfer(amount);
        employee_two.transfer(amount); 
        employee_three.transfer(amount);

        // Take care of a potential remainder by sending back to HR (`msg.sender`)
        msg.sender.transfer(msg.value - (amount *3));
    }

Create deposit function that will be publicly visible, and by adding the modifier `payable` it will accept the ether send when this function is used.

## `uint amount = msg.value / 3`


`uint amount` : is a local varaible because it is called within the function and it stored in the stack memory.

`msg.value/3` : is a global variable which exist in global workspace and provide information about the blockchain and transaction properties. it will return the number of wei sent with the message.

* we are defining the local variable which is the positive integer (amount) equals to the global variable's value of this message equally divided by the three employees.

`employee_one.transfer(amount)` beacuse we added `payable` to the function, we can use the `transfer` member to transfer specified amount to each employee.


## Fallback Function

    function() external payable {
        deposit();
    }

* It is called when a non-existent function is called on the contract.
* It is required to be marked external
* It has no name.
* It has no arguments
* It can not return any thing.
* It can be defined one per contract.
* If not marked payable, it will throw exception if contract receives plain ether without data.

In this contract, our fallback function is here basically to accept deposits to the contract wallet when Ether is send without the `function deposit` set earlier.

-------------------------
## General Layout of Solidity Smart Contracts

###  Pragma statement
###  Import statements
###  Interfaces
###  Libraries
###  Contract


## Style Guidelines for Solidity

* Two blank lines should surround all top-level declarations
* One blank line is enough for function declarations
* you can only use double quotes for data strings.
* Start the line with // to include a single-line comment.
* Start with /* and end with */ to include a multi-line comment.

## Constant State Variable
It's possible to declare state variable with solidity as constant, this assignment takes place during the compilling process since it must be set from a constatnt expression. They are used for strings & value types, as follows:

    pragma solidity >=0.4.0 <0.7.0;

    contract x {
        uint constant x= 32**22 + 8;
        string constant text = "abc";
    }





