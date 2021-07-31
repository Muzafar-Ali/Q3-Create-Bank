pragma solidity ^0.8.0;

contract Bank {
    address owner;
    uint256 counter;
    // Req: 4) Bank will maintain balances of accounts
    mapping(address => uint256) private account_balances;

    event accounts_events(address);

    // Req: 1) The owner can start the bank with initial deposit/capital in ether (min 50 eths)
    constructor() payable {
        require(msg.value >= 50 ether, "start bank with minimum 50 ethers");
        owner == msg.sender;
        counter = 0;
    }

    // Req: 2) Only the owner can close the bank. Upon closing the balance should return to the Owner
    function close_Bank() external payable {
        require(msg.sender == owner, "You are not the Owner");
        selfdestruct(payable(owner));
    }

    // Req: 3) Anyone can open an account in the bank for Account opening they need to deposit ether with address
    // Req: 7) First 5 accounts will get a bonus of 1 ether
    function Open_Account() external payable {
        require(msg.value > 0, "Deposit should be more than 0 to open account");
        account_balances[msg.sender] = msg.value;
        if (counter <= 4) {
            account_balances[msg.sender] += 1 ether;
            counter++;
        }
    }

    // Req: 5) Anyone can deposit in the bank
    function deposit(address payable _Deposit_Account) external payable {
        require(
            account_balances[_Deposit_Account] > 0,
            "Open Your Account first to deposit"
        );
        account_balances[_Deposit_Account] += msg.value;
    }

    // Req: 6) Only valid account holders can withdraw
    function withdrwa(uint256 _amount) external payable {
        require(
            account_balances[msg.sender] > 0,
            "you dont have account in the bank"
        );
        payable(msg.sender).transfer(_amount);
        account_balances[msg.sender] -= _amount;
    }

    // Req: 8) Account holder can inquiry balance
    function inquire_balance() external view returns (uint256) {
        return account_balances[msg.sender];
    }

    //Req : 9)The depositor can request for closing an account
    function close_account() external payable {
        payable(msg.sender).transfer(account_balances[msg.sender]);
    }
}
