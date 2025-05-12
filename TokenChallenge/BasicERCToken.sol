// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BasicERCToken {
    string public Name;
    string public Symbol;
    uint8 private Decimals;
    uint256 public TotalSupply;
    address private Owner;
    bool private paused;

    // Mapping
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    // Events
    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 amount
    );
    event burn(address indexed account, uint256 amount);

    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 _totalsupply
    ) {
        Name = _name;
        Symbol = _symbol;
        Decimals = _decimals;
        TotalSupply = _totalsupply * 10**_decimals;
        Owner = msg.sender;

        _balances[msg.sender] = TotalSupply;

        emit Transfer(address(0), msg.sender, TotalSupply);
    }

    // Modifire
    modifier onlyOwner() {
        require(msg.sender == Owner, "You are not owner");
        _;
    }

    modifier whenNotPoused(){
        require(!paused , "Token transfer are paused");
        _;
    }

    modifier whenPoused(){
        require(paused,"Token transfer are not paused");
        _;
    }


    function _paused() public onlyOwner whenNotPoused{
        paused = true;
    }

    function _unpaused() public onlyOwner whenPoused{
        paused = false;
    }

    function transfer(address to, uint256 amount) public whenNotPoused returns (bool) {
        require(to != address(0), "transfer to Zero");
        require(_balances[msg.sender] >= amount, "Insufficient balance");

        _balances[msg.sender] -= amount;
        _balances[to] += amount;

        emit Transfer(msg.sender, to, amount);

        return true;
    }

    function Allowance(address owner, address spender)
        public
        view
        returns (uint256)
    {
        return _allowances[owner][spender];
    }

    function Approve(address spender, uint256 amount) public whenNotPoused returns (bool) {
        require(spender != address(0),"Approved to zero address");
        require(amount == 0 || _allowances[msg.sender][spender] == 0,"Approve can only reset to 0 first");

        _allowances[msg.sender][spender] = amount;

        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function TransferFrom(
        address from,
        address to,
        uint256 amount
    ) public whenNotPoused returns (bool) {
        require(from != address(0), "Transfer from zero");
        require(to != address(0), "Transfer form zero");
        require(_balances[from] >= amount, "You don't have sufficient balance");
        require(
            _allowances[from][msg.sender] >= amount,
            "You don't have sufficient balance"
        );

        _balances[from] -= amount;
        _balances[to] += amount;
        _allowances[from][msg.sender] -= amount;

        emit Transfer(from, to, amount);
        return true;
    }

    function Burn(address account, uint256 amount) public onlyOwner{
        _Burn(account,amount);
    }

    function BurnFrom(address account,uint256 amount) public whenNotPoused{
        uint256 currentAllowance = _allowances[account][msg.sender];
        require(currentAllowance >= amount ,"Burn amount exceeds allowance");

        _allowances[account][msg.sender] = currentAllowance - amount;
        _Burn(account, amount);
    }

    function _Burn(address account,uint256 amount) internal {
        require(account != address(0),"Zero Address");
        require(_balances[account] >= amount, "burn amount exceeds");

        _balances[account] -= amount;
        TotalSupply -= amount;
        emit burn(account, amount);
    }
}
