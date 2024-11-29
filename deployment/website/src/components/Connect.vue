<script setup lang="ts">
import { useConnect } from '@wagmi/vue'

const { connect, connectors, error, status } = useConnect()
const chainId = 11155111
</script>

<template>
  <div class="min-h-screen flex items-center justify-center bg-gradient-to-br from-purple-50 to-purple-100 p-4">
    <div class="w-full max-w-md bg-white shadow-xl rounded-xl p-6 text-center">
      <h2 class="text-3xl font-bold text-purple-900 mb-6">Wallet Connection</h2>
      
      <div v-if="status !== 'success' && connectors.length != 0" class="space-y-2">
        <button
          v-for="connector in connectors"
          :key="connector.id"
          type="button"
          @click="connect({ connector, chainId })"
          class="w-full py-2 px-4 bg-purple-600 text-white font-semibold rounded-lg shadow-md hover:bg-purple-700 focus:outline-none focus:ring-2 focus:ring-purple-500 focus:ring-opacity-75"
        >
          {{ connector.name }}
        </button>
      </div>
      <div v-else>
        No wallet found go next !
      </div>
    </div>
  </div>
</template>