pragma solidity ^0.4.0;

contract PayCheck{
	//Fill in array with addresses
    address[] employees = [];

    uint totalRecieved = 0;
    mapping(address => uint) withdrawnAmounts;
    
    function withdraw() canWithdraw {
        uint amountAllocatedPerEmployee = totalRecieved/employees.length;
        uint amountWithdrawn = withdrawnAmounts[msg.sender];
        uint amount = amountAllocatedPerEmployee - amountWithdrawn;
        withdrawnAmounts[msg.sender] = amountWithdrawn + amount;
        
        if(amount > 0) {
            msg.sender.transfer(amount);
        }
    }
    
    function PayCheck() payable {
         updateTotal();
    }
    
    function () payable {
        updateTotal();
    }
    
    // Internal functions can only be called from inside contract
    function updateTotal() internal {
        totalRecieved += msg.value;
    }
    
    modifier canWithdraw() {
        bool contains = false;
        
        // Loop through array of employees and see if the sender matches and is authorized to withdraw
        for(uint i=0; i < employees.length; i++) {
            if(employees[i] == msg.sender){
                contains = true;
            }
        }
        // Checks contains if its false it will stop, if true it will continue
        require(contains);
        _;
    }
}