// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";
// import "@openzeppelin/contracts/security/Pausable.sol";

contract OpenToken is ERC20 {
    constructor(uint256 initialSupplay) ERC20("MyToken", "MTK") {
        _mint(msg.sender, initialSupplay * 10**decimals());
    }

    // function mint(address to, uint256 amount) public onlyOwner {
    //     _mint(to, amount);
    // }

    // function burn(uint256 amount) public {
    //     _burn(msg.sender, amount);
    // }

    // function pause() public onlyOwner {
    //     _pause();
    // }

    // function unPause() public onlyOwner {
    //     _unpause();
    // }

    // function _beforeTokenTransfer(
    //     address from,
    //     address to,
    //     uint256 amount
    // ) internal override(ERC20) whenNotPaused {
    //     super._beforeTokenTransfer(from, to, amount);
    // }
}
