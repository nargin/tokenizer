<script setup lang="ts">
import { ref } from 'vue'
import { useAccount, useWriteContract, useReadContract } from '@wagmi/vue'
import { parseEther, Address } from 'viem'

// interface Transaction {
//   from: Address
//   to: Address
//   value: bigint
//   token: Address
//   executed: boolean
//   confirmations: bigint
//   data: `0x${string}`
// }

const contractAddress: Address = '0x337725cEaDE5c1Ea56c867155f6f6a5BaDf95259'
const contractABI = [
  {
    name: 'submitTransaction',
    type: 'function',
    stateMutability: 'payable',
    inputs: [
      { name: '_to', type: 'address' },
      { name: '_value', type: 'uint256' },
      { name: '_token', type: 'address' }
    ]
  },
  {
    name: 'getOwners',
    type: 'function',
    stateMutability: 'view',
    inputs: [],
    outputs: [{ type: 'address[]' }]
  }
] as const

const { address, isConnected } = useAccount()
const { writeContract, isPending } = useWriteContract()
const { data: owners } = useReadContract({
  address: contractAddress,
  abi: contractABI,
  functionName: 'getOwners'
})

const transferAmount = ref<string>('1')
const tokenAddress = ref<Address>('0x19cB76f49dB0921b2099f06A4E74413690945c16')
const selectedOwner = ref<Address>()
const transactionError = ref<string | null>(null)

const submitTransactionToOwner = async () => {
  transactionError.value = null

  if (!isConnected.value) {
    transactionError.value = 'Wallet not connected'
    return
  }

  if (!selectedOwner.value) {
    transactionError.value = 'Select an owner'
    return
  }

  if (!transferAmount.value || parseFloat(transferAmount.value) < 0) {
    transactionError.value = 'Invalid amount'
    return
  }

  try {
    await writeContract({
      address: contractAddress,
      abi: contractABI,
      functionName: 'submitTransaction',
      args: [
        selectedOwner.value, 
        parseEther(transferAmount.value),
        tokenAddress.value || '0x0000000000000000000000000000000000000000' as Address,
      ],
      value: parseEther(transferAmount.value)
    })
  } catch (err: any) {
    transactionError.value = err.message || 'Transaction failed'
  }
}
</script>

<template>
  <div class="max-w-md mx-auto bg-white shadow-lg rounded-lg p-6 space-y-4">
    <h2 class="text-2xl font-bold text-center text-gray-800 mb-4">Multisig Transaction</h2>
    
    
    <div class="space-y-4">        
        <div v-if="owners && owners.length" class="mt-4">
            <h3 class="font-semibold mb-2">Owners:</h3>
            <div 
            v-for="(owner, index) in owners" 
          :key="index" 
          class="p-2 rounded mb-1 border"
        >
          {{ owner }}
        </div>
    </div>

    <div 
      v-if="transactionError" 
      class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded" 
    >
      {{ transactionError }}
    </div>

      <select 
        v-model="selectedOwner"
        class="w-full px-3 py-2 border rounded-md"
      >
        <option value="">Select Owner</option>
        <option 
          v-for="(owner, index) in owners" 
          :key="index" 
          :value="owner"
        >
          {{ owner }}
        </option>
      </select>
      
      <input 
        v-model="transferAmount"
        type="number" 
        placeholder="Transfer Amount"
        class="w-full px-3 py-2 border rounded-md"
      />
      
      <input 
        v-model="tokenAddress"
        type="text"
        placeholder="Token Address (Optional)"
        class="w-full px-3 py-2 border rounded-md"
      />
      
      <button 
        @click="submitTransactionToOwner"
        :disabled="isPending"
        class="w-full bg-indigo-600 text-white px-4 py-2 rounded"
      >
        {{ isPending ? 'Submitting...' : 'Submit Transaction' }}
      </button>
    </div>
  </div>
</template>