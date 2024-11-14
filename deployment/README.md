# Tokenizer Project - V42GR Token Deployment

This document outlines the deployment information and interaction guide for the Veigar42winrate (V42GR) token, created as part of the 42 School Tokenizer project.

## Token Information

- **Name:** Veigar42winrate
- **Symbol:** V42GR
- **Decimals:** 18
- **Initial Supply:** 27,341 tokens
- **Contract Address (Sepolia):** `0x19cB76f49dB0921b2099f06A4E74413690945c16`
- **Network:** Sepolia Testnet

## Contract Features

- ERC20 standard compliance
- Ownership controls (Ownable)
- Pausable functionality
- Custom decimal configuration (18 decimals)
- Burn mechanism (burnOne function)
- Minting capability (restricted to owner)
- String printer function

## Interacting with the Contract

### Using MetaMask

1. Add Sepolia Network to MetaMask:

   - Network Name: Sepolia Test Network
   - RPC URL: https://sepolia.infura.io/v3/
   - Chain ID: 11155111
   - Currency Symbol: SEP
   - Block Explorer: https://sepolia.etherscan.io
2. Add Token to MetaMask:

   - Click "Import Token"
   - Paste contract address: `0x19cB76f49dB0921b2099f06A4E74413690945c16`
   - Token Symbol: V42GR
   - Decimals: 18

### Using Web Interface

To interact with the token through a web interface:

1. Connect your wallet using the MetaMask browser extension
2. Ensure you're connected to Sepolia network
3. Available functions:

   - `burnOne()`: Burns 1 token from your balance
   - `pause()`: Pauses token transfers (owner only)
   - `unpause()`: Resumes token transfers (owner only)
   - `mint(uint256 _amount)`: Creates new tokens (owner only)
   - `printer(string)`: Returns the input string

## Getting Test ETH

To interact with the contract on Sepolia, you'll need test ETH:

1. Visit the [Sepolia Faucet](https://sepoliafaucet.com)
2. Connect your wallet
3. Request test ETH (usually 0.5 SEP per day)

## Security Considerations

- The contract includes standard OpenZeppelin security features
- Owner has special privileges (minting, pausing)
- Burning is available to all users
- Contract is pausable in case of emergencies

## Development Notes

The contract is built using:

- Solidity ^0.8.0
- OpenZeppelin contracts for:
  - ERC20 implementation
  - Ownable access control
  - Pausable functionality
