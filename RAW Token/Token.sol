// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Token{

    // Initial context must need
    string public name;
    string public symbol;
    uint8 private decimals;
    uint256 public totalSupply;

    // mapping need
    mapping (address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowances;

    // Event need
    event transfer(address indexed from, address indexed to, uint256 value);
    event approved(address indexed owner, address indexed spender, uint256 value);

    constructor(string memory _name,string memory _symbol, uint8 _decimals,uint256 _totalSupply){
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _totalSupply;
        _balances[msg.sender] = totalSupply;
        emit transfer(address(0), msg.sender, totalSupply);
    }

    function Transfer(address to, uint amount) public returns(bool){
        require(to != address(0),"Transfer to zero address");
        require(_balances[msg.sender] >= amount,"You don't have sufficient balance");

        _balances[msg.sender] -= amount;
        _balances[to] += amount;

        emit transfer(msg.sender, to, amount);
        return true;
    }

    function allowance(address owner,address spender) public view returns(uint256){
        return _allowances[owner][spender];
    }

    function approve(address spender, uint amount) public returns(bool){
        _allowances[msg.sender][spender] = amount;

        emit approved(msg.sender, spender, amount);

        return true;
    }

    function TransferFrom(address from,address to,uint amount) public returns(bool){
        require(from != address(0),"Transfer to zero address");
        require(to != address(0),"Transfer to zero address");
        require(_balances[from] >= amount,"Sufficient Balance");
        require(_allowances[from][msg.sender] >= amount,"Sufficient Balance");

        _balances[from] -= amount;
        _balances[to] += amount;
        _allowances[from][msg.sender] -= amount;

        emit transfer(from, to, amount);

        return true;
    }



}