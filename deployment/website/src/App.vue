<script setup lang="ts">
import Account from './components/Account.vue'
import Connect from './components/Connect.vue'
import Interaction from './components/Interaction.vue'
import Multisig from './components/Multisig.vue';
import { useAccount } from '@wagmi/vue';

const { status } = useAccount();
</script>

<template>
  <div class="min-h-screen flex flex-col items-center justify-start pt-0">
    <div v-if="status !== 'connected'" class="w-full max-w-md">
      <Connect />
    </div>
    <div v-else class="flex flex-col md:flex-row items-center space-y-4 md:space-y-0 md:space-x-4">
      <Account />
      <Interaction />
      <Multisig />
    </div>
  </div>
</template>