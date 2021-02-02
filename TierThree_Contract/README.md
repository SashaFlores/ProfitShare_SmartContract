# Tier Three contract

## State Variables

    contract TierThree {
    address human_resources;
    address payable employee; 
    bool active = true; 

* Human resource address
* `employee` address payable to accept ethers
* `employee` has to be active at the beginning of the contract




        uint total_shares = 1000;
        uint annual_distribution = 250; 
        uint start_time = now; 
        uint public unlock_time = start_time + 365;
        uint public distributed_shares;

* State variable `total_shares` is unsigned integer with a value of 1000 shares
* State variable `annual_distribution` equals to `total_shares` divided by 4, as 1000 shares each 4 years distributed annually
* `start_time = now` to mark the start time when the contract was initiate it
* `unlock_time` to unlock shares distribution, employee has to spend a year in the company so we set unlock time after 365 days
* `distributed_shares`

## constructor

    constructor(address payable _employee) public {
        human_resources = msg.sender;
        employee = _employee;
    }

* `address payable _employee` 
  * is the argument passed in constructor which gets executed once per contract life when deployed. 
  * Unscored employee will allow us to manually input employee address, a huge merit to reuse the smart contract more than one-time as well as to protect sensitive data from security breaches.
  * The contract will not be deployed before providing the input parameter, and an Error will be displayed

* `human_resources = msg.sender` 

  * `human_resources` address specified in the State Variables has to be the message sender 
* `employee = _employee` employee specified in the State Variables is equal to the `_employee`

## Functions

    function distribute() public {
        require(msg.sender == human_resources || msg.sender == employee, "You are not authorized
        to execute this contract.");
        require(active == true, "Contract not active.");
        require(unlock_time <=now, "Shares are not yet vested");
        require(distributed_shares <= total_shares, "All Shares distributed");
        unlock_time +=365;
        distributed_shares = ((now - start_time) / 365 days * annual_distribution);
        if (distributed_shares > 1000) {
            distributed_shares = 1000;
        }
    }



* `distribute` function is a getter function which is publicly visible, and require that message sender address is the human resources address or the employee address, otherwise thsi message will pops up `You are not authorized to execute this contract`
* Second requirement is that the `employee` to be `active` or user will get `Contract not active` message.
* `unlock_time <=now` if now is less than or equal unlock_time, user can't get his shares and instead will `Shares are not yet vested`
* `distributed_shares <= total_shares` distributed_shares is less than the total_shares
* Unlock time to distribute shares after the employee spends a full year with the compant

  
    
    ## Getter Functions

    *  is a function that returns a value.
    *  it doesn't modify the state of the contract
    *  Example for getter functions structure:
  
            contract Score {
            
                uint score = 5;
                function getScore() returns (uint) {
                    return score;
                }


    ## Setter Functions

    *  is a function that modifies the value of a variable (modifies the state of the contract)
    *   must specify the parameters when you declare your function.
    *   Example for setter functions structure:
       
            function setScore(uint new_score) {
                score = new_score;
            }   

 </n>

 
    function deactivate() public {
        require(msg.sender == human_resources || msg.sender == employee, "You are not authorized 
        to deactivate this contract.");
        active = false;
    }

* allows Either human_resources or employee to decative this contract


        function() external payable {
            revert("Do not send Ether to this contract!");
        }

        * Fallback Function to revert any Ether may be send to this contract after deactiavtion


------------

Resources:

- [Solidity Tutorials](http://extropy.foundation/workshops/bootcamp/soliditytutorial.html#11-Getter-function-using-return)

- Assert, revert, and require [Solidity Error Hanlding](https://www.tutorialspoint.com/solidity/solidity_error_handling.htm)


