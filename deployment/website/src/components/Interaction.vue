<script setup lang="ts">
import { ref } from 'vue'
import { useAccount, useWriteContract } from '@wagmi/vue'
import { parseEther } from 'viem'

const contractAddress = "0x19cB76f49dB0921b2099f06A4E74413690945c16"
const contractABI = [
  // Mint function
  {
    "name": "mint",
    "type": "function",
    "stateMutability": "nonpayable",
    "inputs": [{"name": "_amount", "type": "uint256"}],
    "outputs": []
  },
  // Burn function
  {
    "name": "burnOne",
    "type": "function",
    "stateMutability": "nonpayable",
    "inputs": [],
    "outputs": []
  }
]

const { address, status } = useAccount()
const { writeContract } = useWriteContract()

// Minting state
const mintAmount = ref('')
const isMinting = ref(false)

// Burning state
const isBurning = ref(false)

// Mint tokens
const handleMint = async () => {
  if (!address.value) {
    alert('Please connect your wallet first')
    return
  }

  try {
    isMinting.value = true
    writeContract({
      address: contractAddress,
      abi: contractABI,
      functionName: 'mint',
      args: [parseEther(String(mintAmount.value))]
    })
  } catch (error) {
    console.error('Minting failed:', error)
    alert('Minting failed')
  } finally {
    isMinting.value = false
    mintAmount.value = ''
  }
}

// Burn tokens
const handleBurn = async () => {
  if (!address.value) {
    alert('Please connect your wallet first')
    return
  }

  try {
    isBurning.value = true
    writeContract({
      address: contractAddress,
      abi: contractABI,
      functionName: 'burnOne'
    })
  } catch (error) {
    console.error('Burning failed:', error)
    alert('Burning failed')
  } finally {
    isBurning.value = false
  }
}
</script>

<template>
  <div class="max-w-md mx-auto bg-white shadow-lg rounded-lg p-6 space-y-4">
    <h2 class="text-2xl font-bold text-center text-gray-800 mb-4">Token Interactions</h2>

    <div v-if="status !== 'connected'" class="text-center text-red-500">
      Please connect your wallet first
    </div>

    <div v-else class="space-y-4">
      <!-- Mint Section -->
      <div class="bg-gray-100 p-4 rounded-md">
        <h3 class="text-lg font-semibold mb-2 text-gray-700">Mint Tokens</h3>
        <div class="flex space-x-2">
          <input 
            v-model="mintAmount" 
            type="number" 
            placeholder="Amount to mint" 
            class="flex-grow p-2 border rounded"
          />
          <button 
            @click="handleMint"
            :disabled="isMinting || !mintAmount"
            class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600 disabled:opacity-50"
          >
            {{ isMinting ? 'Minting...' : 'Mint' }}
          </button>
        </div>
      </div>

      <!-- Burn Section -->
      <div class="bg-gray-100 p-4 rounded-md">
        <h3 class="text-lg font-semibold mb-2 text-gray-700">Burn Token</h3>
        <button 
          @click="handleBurn"
          :disabled="isBurning"
          class="w-full bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600 disabled:opacity-50"
        >
          {{ isBurning ? 'Burning...' : 'Burn One Token' }}
        </button>
      </div>
    </div>
  </div>
</template>

<style scoped>
input[type="number"] {
  /* Remove spin buttons in WebKit browsers (Chrome, Safari) */
  -webkit-appearance: textfield;
  -moz-appearance: textfield;
  appearance: textfield;
}

input[type="number"]::-webkit-outer-spin-button,
input[type="number"]::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}
</style>