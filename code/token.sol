// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Veigar42winrate is ERC20, Ownable {
    uint8 private constant _decimals = 18;
    uint256 private constant INITIAL_SUPPLY = 27; // 27 tokens

    constructor(address initialOwner) ERC20("Veigar42winrate", "V42GR") Ownable(initialOwner) {
        _mint(msg.sender, INITIAL_SUPPLY * 10 ** decimals());
    }

    function decimals() public pure override returns (uint8) {
        return _decimals;
    }

    function burnOne() public {
        _burn(msg.sender, 10 ** decimals());
    }

    function printer(string memory _src) public pure returns (string memory) {
        return _src;
    }

    function mint(uint256 _amount) public onlyOwner {
        _mint(msg.sender, _amount);
    }
}