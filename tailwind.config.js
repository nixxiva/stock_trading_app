/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/views/**/*.{html.erb,html.slim}',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}