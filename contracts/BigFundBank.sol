//  Implementation contract allowing people to deposit Ether and withdraw on demand.

import "@openzeppelin/contracts/proxy/utils/Initializable.sol";

pragma solidity ^0.8.10;

contract BigFundBank is Initializable{

    string public name;
    uint256 public initBalance;
    mapping(address=>uint256) public depositTime;
    mapping(address=>uint256) public balances;

    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 amount
    );

    function initialize(string memory _name,uint256 memory _balance) public initializer{
        name = _name;
        initBalance = _balance;
    }

    function depositFunds(uint256 _amount) public payable{
        balances[msg.sender] += _amount;
        depositTime[msg.sender] = now;
    }

    function mintFunds() public payable{
        require(balances[msg.sender] >= 1);
        balances[msg.sender] += 1;
    }

    function checkBalance() public view returns(uint){
        return balances[msg.sender];
    }   

    function withdrawFunds(uint256 memory _amount) public payable{
        require(now > depositTime[msg.sender] + 1 min);
        require(balances[msg.sender]>=_amount);
        balances[msg.sender] -= _amount;
        (bool sent,) = msg.sender.send{value:_amount}();
        require(sent,'Invalid');
    }

    function transfer(address memory _to,uint256 memory _amount) public returns(bool success){
        require(balances[msg.sender] >= _amount);
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
        emit Transfer(msg.sender,_to,_amount);
        return true;
    }
}