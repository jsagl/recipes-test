/** @type {import('tailwindcss').Config} */
module.exports = {
    content: [
        './public/*.html',
        './app/helpers/**/*.rb',
        './app/javascript/**/*.{js,jsx}',
        './app/views/**/*',
    ],
    theme: {
        extend: {},
    },
    plugins: [],
}
