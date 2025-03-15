module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['M PLUS Rounded 1c', 'ui-sans-serif', 'system-ui'],
        serif: ['Merriweather', 'ui-serif', 'Georgia'],
      },
      colors: {
        tealGreen: "#006a6c",   // テールグリーン
        oliveGreen: "#556B2F",  // オリーブグリーン
        warmBrown: "#5A4D41",   // ウォームブラウン
        deepBlue: "#1B3A4B",    // ディープブルー
        offWhite: "#F4F1EB",    // オフホワイト
        lightGreen: "#A3C9A8",  // ライトグリーン
      },
    },
  },
  plugins: [require("daisyui")],
}