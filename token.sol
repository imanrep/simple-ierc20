// SPDX-License-Identifier: Unlicensed

pragma solidity 0.8.0;

contract simpleERC20 {

    string public name = "OWO";
    string public symbol = "OWI";
    uint public decimals = 18;
    uint256 _totalSupply = 10000 * 10 ** decimals;

    event Transfer(address from, address to);
    event Approval(address from, address to, uint256 amount);

    mapping (address => uint256) balance;
    mapping (address => mapping (address => uint256)) allowances;

    constructor() {
        balance[msg.sender] = _totalSupply;
    }

    function totalSupply() public view returns(uint256) {
        return _totalSupply;
    }

    function balanceOf(address _adr) public view returns(uint256) {
        return balance[_adr];
    }

    function transfer(address _to, uint256 _amount) public {
        uint256 balanceSender = balance[msg.sender];
        require(_amount <= balanceSender, "Too much");
        balanceSender = balanceSender - _amount;
        balance[_to] = balance[_to] + _amount;
        emit Transfer(msg.sender, _to);
    }

    function allowance(address _owner, address _spender) public view returns (uint256) {
        return allowances[_owner][_spender];
    }

    function approve(address _spender, uint256 _amount) public {
        allowances[msg.sender][_spender] = _amount;
        emit Approval(msg.sender, _spender, _amount);
    }

    function transferFrom(address _from, address _to, uint256 _amount) public {
        uint256 balanceSender = balance[_from];
        if(_from != msg.sender) {
            require(allowances[_from][msg.sender] >= _amount , "Allowance Limit");
        }
        require(_amount <= balanceSender, "Too much");
        balanceSender = balanceSender - _amount;
        balance[_to] = balance[_to] + _amount;
        emit Transfer(msg.sender, _to);
    }
}
