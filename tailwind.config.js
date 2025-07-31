export const content = [
    "./app/views/**/*.{html.erb,html.slim}", // Tailwind should scan all .html.erb and .html.slim files in your views folder
    "./app/helpers/**/*.rb", // Tailwind should scan helpers (for classes used in helper files)
    "./app/javascript/**/*.js", // Tailwind should scan your JavaScript files for dynamic class names
];
export const theme = {
    extend: {},
};
export const plugins = [];