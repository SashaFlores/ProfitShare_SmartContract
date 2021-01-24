pragma solidity ^0.5.0;


contract TierThree {
    address human_resources;

    address payable employee; // bob
    bool active = true; // this employee is active at the start of the contract

    // Set the total shares and annual distribution
    uint total_shares = 1000;
    uint annual_distribution = 250; // 1000 shares for 4 years

    uint start_time = now; // permanently store the time this contract was initialized

    // Set the `unlock_time` to be 365 days from now
    uint public unlock_time = start_time + 365;

    uint public distributed_shares; // starts at 0

    constructor(address payable _employee) public {
        human_resources = msg.sender;
        employee = _employee;
    }

    function distribute() public {
        require(msg.sender == human_resources || msg.sender == employee, "You are not authorized to execute this contract.");
        require(active == true, "Contract not active.");

        // Add "require" statements to enforce that:
        
        // 1: `unlock_time` is less than or equal to `now`
        require(unlock_time <=now, "Shares are not yet vested");
        // 2: `distributed_shares` is less than the `total_shares`
        require(distributed_shares <= total_shares, "All Shares distributed");
        

        // Add 365 days to the `unlock_time`
        unlock_time +=365;

        // Calculate the shares distributed 
        distributed_shares = ((now - start_time) / 365 days * annual_distribution);

        // double check in case the employee does not cash out until after 5+ years
        if (distributed_shares > 1000) {
            distributed_shares = 1000;
        }
    }

    // human_resources and the employee can deactivate this contract at-will
    function deactivate() public {
        require(msg.sender == human_resources || msg.sender == employee, "You are not authorized to deactivate this contract.");
        active = false;
    }

    // Since we do not need to handle Ether in this contract, revert any Ether sent to the contract directly
    function() external payable {
        revert("Do not send Ether to this contract!");
    }
}