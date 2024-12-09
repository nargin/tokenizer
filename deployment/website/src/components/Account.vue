<script setup lang="ts">
import { useAccount, useDisconnect, useBalance } from '@wagmi/vue'
import { formatEther } from 'viem'
import { computed } from 'vue'

const veigar42Token = "0x19cB76f49dB0921b2099f06A4E74413690945c16"

const { address, chainId, status } = useAccount()
const { disconnect } = useDisconnect()

const { data: balanceData } = useBalance({
  address: address,
  token: veigar42Token,
})

const { data: ethBalanceData } = useBalance({
  address: address,
})

const balance = computed(() => 
  balanceData.value 
    ? formatEther(balanceData.value.value) 
    : "NULL"
)

const ethBalance = computed(() =>
  ethBalanceData.value
    ? formatEther(ethBalanceData.value.value)
    : "NULL"
)

</script>

<template>
  <div class="max-w-md mx-auto bg-white shadow-lg rounded-lg p-6 space-y-4">
    <h2 class="text-2xl font-bold text-center text-gray-800 mb-4">Account Details</h2>

    <div class="bg-gray-100 p-4 rounded-md space-y-1">
      <div class="flex justify-between items-center">
        <span class="font-semibold text-gray-600">Account: </span>
      </div>
      <div class="text-blue-600 font-mono text-sm">
        {{ address }}
      </div>
      
      <div class="flex justify-between items-center">
        <span class="font-semibold text-gray-600">Chain ID: </span>
        <span class="text-gray-800">{{ chainId }}</span>
      </div>

      <div class="flex justify-between items-center">
        <span class="font-semibold text-gray-600">Status: </span>
        <span 
          :class="[
            'px-2 py-1 rounded-full text-sm font-medium',
            status === 'connected' 
              ? 'bg-green-100 text-green-800' 
              : 'bg-yellow-100 text-yellow-800'
          ]"
        >
          {{ status }}
        </span>
      </div>

      <div 
        v-if="balance !== 'NULL'" 
        class="flex justify-between items-center"
      >
        <span class="font-semibold text-gray-600">Balance: </span>
        <span class="text-purple-600 font-bold">
          <br />
          - {{ balance }} V42GR
          <br />
          - {{ ethBalance }} SepoliaETH
        </span>
      </div>
    </div>

    <button 
      v-if="status !== 'disconnected'" 
      type="button" 
      @click="disconnect()"
      class="w-full bg-purple-600 text-white py-2 rounded-md hover:bg-purple-700 transition-colors duration-300"
    >
      Disconnect Wallet
    </button>
  </div>
</template>

<style scoped>
/* Optional additional custom styles */
@keyframes pulse {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.05); }
}

.animate-pulse {
  animation: pulse 2s infinite;
}
</style>