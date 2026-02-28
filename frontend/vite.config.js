import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  server: {
    port: 5173,
    // Proxy API calls → backend (dev mode)
    proxy: {
      '/equipment': 'http://localhost:4000',
      '/history':   'http://localhost:4000',
      '/auth':      'http://localhost:4000',
      '/uploads':   'http://localhost:4000',
    }
  }
})
