// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract SharedWallet{
    address private owner;
    mapping(address=>User) private users;

    event giveUserAllowanceEvent(address _adr, uint _amount, uint _timeStamp);
    event spendEvent(address _des,uint _amount);

    struct User{
        address adr;
        uint allowance;
        uint validity;
    }

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner{
        require(msg.sender==owner, "Only owner can use this feature.");
        _;
    }

    receive() external payable onlyOwner {}

    function checkBalance() view external onlyOwner returns(uint){
        return address(this).balance;
    }

    function giveUserAllowance(address _adr, uint _amount, uint _timeStamp) external onlyOwner {
        uint validity = block.timestamp + _timeStamp;
        User memory user = User(_adr, _amount, validity);
        users[_adr] = user;
        emit giveUserAllowanceEvent(_adr, _amount,  _timeStamp);
    }

    function spend(address _des,uint _amount) external payable returns(bool){
        User memory user = users[msg.sender];
        require(_amount<=user.allowance, "Your allowance is not sufficient.");
        require(block.timestamp<=user.validity, "Your validity date is expired.");
        users[msg.sender].allowance -= _amount;
        (bool sent, ) = _des.call{value: _amount}("");
        emit spendEvent(_des, _amount);
        return sent;
    }

}