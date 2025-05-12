// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract AdvanceOpenToken is ERC20, Ownable, ERC20Permit {
    uint256 private maxSupply;

    constructor(uint256 initalSupply, uint256 _maxSupply)
        ERC20("MyToken", "MT")
    {
        require(
            _maxSupply >= initalSupply,
            "Max supply must be greater then initial supply"
        );
        _mint(msg.sender, initalSupply * 10**decimals());
    }

    function mint(address to, uint256 amount) public OnlyOwner {
        require(
            totalSupply() + amount >= maxSupply,
            "Cannot exceed max token supply"
        );
        _mint(to, amount);
    }
}
