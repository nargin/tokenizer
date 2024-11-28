<script setup lang="ts">
import { useChainId, useConnect } from '@wagmi/vue'

const chainId = useChainId()
const { connect, connectors, error, status } = useConnect()
</script>

<template>
  <h2>Connect</h2>

  <button v-for="connector in connectors" :key="connector.id" type="button" @click="connect({ connector, chainId })">
    {{ connector.name }}
  </button>

  <div>
    Connection status: {{ status }}
  </div>
  <div v-if="error?.message">
    Error: {{ error.message }}
  </div>
</template>
