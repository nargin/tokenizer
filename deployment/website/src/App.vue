<script setup lang="ts">
import Account from './components/Account.vue'
import Connect from './components/Connect.vue'
import Interaction from './components/Interaction.vue'
import { useAccount } from '@wagmi/vue';

const { status } = useAccount();

</script>


<template>
  
  <div v-if="status !== 'connected'">
    <Connect />
  </div>
  <div v-else>
    <Account />
    <Interaction />
  </div>
</template>
