const { webpackConfig } = require('@rails/webpacker')
const { merge } = require('webpack-merge')

const customConfig = {
  resolve: {
    extentions: [".CSS"]
  },
}

module.exports = merge(webpackConfig, customConfig)