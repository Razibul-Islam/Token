// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC {
    function TotalSupply() external view returns (uint256);

    function BalanceOf(address account) external view returns (uint256);

    function Transfer(address to, uint256 amount) external returns (bool);

    function Allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function Approve(address spender, uint256 amount) external returns (bool);

    function TransferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);

    // Events
    event transfer(address indexed from, address indexed to, uint256 amount);
    event approve(
        address indexed owner,
        address indexed spender,
        uint256 amount
    );
}

contract AdvanceToken is IERC {
    string public Name;
    string public Symbol;
    uint256 private totalSupply;
    uint256 private decimals;

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _initialsupply,
        uint256 _decimals
    ) {
        Name = _name;
        Symbol = _symbol;
        totalSupply = _initialsupply * 10**uint256(_decimals);
        decimals = _decimals;
        _balances[msg.sender] = totalSupply;
        emit transfer(address(0), msg.sender, totalSupply);
    }

    function TotalSupply() external view override returns (uint256) {
        return totalSupply;
    }

    function BalanceOf(address account) external view override returns (uint256) {
        return _balances[account];
    }

    function Transfer(address to, uint256 amount) external returns (bool) {
        _Transfer(msg.sender, to, amount);
        return true;
    }

    function Allowance(address owner, address spender) external view returns (uint256) {
        return _allowances[owner][spender];
    }

    function Approve(address spender, uint256 amount) external returns (bool) {
        _Approve(msg.sender, spender, amount);
        return true;
    }

    function TransferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool) {
        _SpenderAllowance(from, msg.sender, amount);
        _Transfer(from, to, amount);
        return true;
    }

    function _Transfer(
        address from,
        address to,
        uint256 amount
    ) internal {
        require(to!=address(0),"Transfer from zero");
        require(_balances[msg.sender] >= amount,"You don't have sufficient balance");

        _balances[msg.sender] -= amount;
        _balances[to] += amount;

        emit transfer(from, to, amount);
    }

    function _Approve(address owner, address spender, uint256 amount) internal {
        _allowances[msg.sender][spender] = amount;

        emit approve(owner, spender, amount);
    }

    function _SpenderAllowance(address owner,address spender,uint256 amount) internal {
        uint256 currentAllowance = _allowances[owner][spender];
        if(currentAllowance != type(uint256).max){
            require(currentAllowance >= amount,"Insufficient balance");
            _Approve(owner, spender, currentAllowance);
        }
    }

}
