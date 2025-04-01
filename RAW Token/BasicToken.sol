// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BasicToken{
    string public Name;
    string public Symbol;
    uint private Decimals;
    uint private TotalSupply;

    // Mapping
    mapping(address => uint) private _balances;
    mapping (address => mapping (address => uint)) private _allowance;

    // Event
    event Transfer(address indexed from, address indexed to, uint amount);
    event Approved(address indexed owner,address indexed spender,uint amount);

    constructor (string memory _name, string memory _symbol,uint _decimals,uint _totalSupply){
        Name = _name;
        Symbol = _symbol;
        Decimals = _decimals;
        TotalSupply = _totalSupply;
        _balances[msg.sender] = TotalSupply;
        emit Transfer(address(0), msg.sender, TotalSupply);
    }

    function transfer(address to, uint amount) public returns(bool){
        require(to != address(0),"Transfer from zero");
        require(_balances[msg.sender] >= amount,"You don't have sufficient balance");

        _balances[msg.sender] -= amount;
        _balances[to] += amount;

        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function Allowance(address owner,address spender) public view returns(uint){
        return _allowance[owner][spender];
    }

    function approve(address spender,uint amount) public returns(bool){
        _allowance[msg.sender][spender] = amount;

        emit Approved(msg.sender, spender, amount);
        return true;
    }

    function TransferFrom(address from,address to,uint amount) public returns(bool){
        require(from != address(0),"Transfer from zero");
        require(to != address(0),"Transfer from zero");
        require(_balances[from] >= amount,"You don't have sufficient balance");
        require(_allowance[from][msg.sender] >= amount,"You don't have sufficient balance");

        _balances[from] -= amount;
        _balances[to] += amount;
        _allowance[from][msg.sender] -= amount;

        emit Transfer(from, to, amount);
        return true;
    }
}