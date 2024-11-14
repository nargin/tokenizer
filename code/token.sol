// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract Veigar42winrate is ERC20, Ownable, Pausable {
    uint8 private constant _decimals = 18;
    uint256 private constant INITIAL_SUPPLY = 27341; // 27 * 1000 tokens + 341

    constructor(
        address initialOwner
    ) ERC20("Veigar42winrate", "V42GR") Ownable(initialOwner) {
        _mint(msg.sender, INITIAL_SUPPLY * 10 ** decimals());
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
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

    function mint(uint256 _amount) public onlyOwner whenNotPaused {
        _mint(msg.sender, _amount);
    }
}

// Token addr: 0x19cB76f49dB0921b2099f06A4E74413690945c16
