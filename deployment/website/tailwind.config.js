/** @type {import('tailwindcss').Config} */
export default {
  content: [
    // Vue template files
    "./index.html",
    "./src/**/*.{vue,js,ts,jsx,tsx}",
    
    // If you have any components in a specific directory
    "./src/components/**/*.{vue,js,ts,jsx,tsx}"
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}