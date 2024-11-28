import { http, createConfig, createStorage } from '@wagmi/vue'
import { sepolia } from '@wagmi/vue/chains'

export const config = createConfig({
  chains: [sepolia],
  connectors: [],
  storage: createStorage({ storage: localStorage, key: 'vite-vue' }),
  transports: {
    [sepolia.id]: http(),
  },
})

declare module '@wagmi/vue' {
  interface Register {
    config: typeof config
  }
}
