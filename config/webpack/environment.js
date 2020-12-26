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

const babelOptions = environment.loaders.get("babel").use[0].options

// Insert rb2js loader at the end of list
environment.loaders.append("rb2js", {
  test: /\.js\.rb$/,
  use: [
    {
      loader: "babel-loader",
      options: { ...babelOptions },
    },
    "@ruby2js/webpack-loader",
  ],
})

module.exports = environment
