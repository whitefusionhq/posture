const { environment } = require("@rails/webpacker")

const path = require("path")
const CopyPlugin = require("copy-webpack-plugin")

environment.plugins.prepend(
  "shoelace",
  new CopyPlugin({
    patterns: [
      {
        from: path.resolve(
          __dirname,
          "../../node_modules/@shoelace-style/shoelace/dist/shoelace/icons"
        ),
        to: "js/icons",
      },
    ],
  })
)

module.exports = environment
