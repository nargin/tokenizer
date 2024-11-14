// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/utils/Context.sol";

contract Veigar42winrate is Context, ERC20, Ownable, Pausable {
    address public multiSigWallet;

    uint8 private constant _decimals = 18;
    uint256 private constant INITIAL_SUPPLY = 42000000;

    event MultiSigWalletSet(address indexed oldWallet, address indexed newWallet);

    constructor(address initialOwner) ERC20("Veigar42winrate", "V42GR") {
        _transferOwnership(initialOwner);
        _mint(initialOwner, INITIAL_SUPPLY * 10 ** decimals());
    }

    function setMultiSigWallet(address _wallet) external onlyOwner {
        require(_wallet != address(0), "Invalid wallet address");
        address oldWallet = multiSigWallet;
        multiSigWallet = _wallet;
        emit MultiSigWalletSet(oldWallet, _wallet);
    }

    function mint(address to, uint256 amount) public virtual {
        require(_msgSender() == multiSigWallet, "Only MultiSig can mint");
        _mint(to, amount);
    }

    function burn(uint256 amount) public virtual {
        require(_msgSender() == multiSigWallet, "Only MultiSig can burn");
        _burn(_msgSender(), amount);
    }

    function pause() public virtual {
        require(_msgSender() == multiSigWallet, "Only MultiSig can pause");
        _pause();
    }

    function unpause() public virtual {
        require(_msgSender() == multiSigWallet, "Only MultiSig can unpause");
        _unpause();
    }

    function decimals() public pure override returns (uint8) {
        return _decimals;
    }
}