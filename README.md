
# Tokenizer Project README

## Project Overview

The Tokenizer project involves the development and deployment of a custom ERC20 token called Veigar42winrate (V42GR). This token is minted with an initial supply of 27,341 tokens and includes features for access control, pausability, and custom token management.

## Key Features

- ERC20 token implementation
- Initial supply of 27,341 tokens
- 18 decimal places
- Owner-controlled minting
- Token burning functionality
- Pausable transfers
- Custom string printer function

## Contract Deployment

The Veigar42winrate token contract was deployed to the Sepolia Ethereum testnet with the following details:

- Contract Address: `0x19cB76f49dB0921b2099f06A4E74413690945c16`
- Initial Owner: Me

## Interacting with the Token

You can interact with the deployed token in the following ways:

### Using MetaMask

1. Add Sepolia Test Network to MetaMask
2. Import the token using the contract address

### Using Etherscan

1. Visit the contract on [Sepolia Etherscan](https://sepolia.etherscan.io/address/0x19cB76f49dB0921b2099f06A4E74413690945c16)
2. Connect your wallet to interact with the contract

### Token Functions

- `burnOne()`: Burns 1 token from your balance
- `pause()`: Pauses token transfers (owner only)
- `unpause()`: Resumes token transfers (owner only)
- `mint(uint256 _amount)`: Creates new tokens (owner only)
- `printer(string)`: Returns the input string

## Getting Test ETH

To interact with the contract on Sepolia, you'll need test ETH. You can obtain test ETH from the [Sepolia Faucet](https://sepoliafaucet.com).

## Resources

- [Sepolia Etherscan](https://sepolia.etherscan.io)
- [MetaMask Documentation](https://docs.metamask.io)
- [OpenZeppelin Documentation](https://docs.openzeppelin.com/contracts/4.x/)
