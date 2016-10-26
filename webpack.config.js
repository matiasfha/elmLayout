const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const autoprefixer      = require('autoprefixer');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const CleanWebpackPlugin = require('clean-webpack-plugin');
const Webpack = require('webpack')
module.exports = {
  entry: [
    'webpack-dev-server/client?http://localhost:8080',
    path.join( __dirname, 'src/index.js' )
  ],


  output: {
    path:       path.resolve( __dirname, 'dist/' ),
    filename: 'bundle.[hash].js',
  },

  resolve: {
    modulesDirectories: ['node_modules'],
    extensions: ['', '.js', '.elm']
  },

  plugins: [
    new CleanWebpackPlugin(['dist']  ),
    new HtmlWebpackPlugin(),
    // new Webpack.optimize.CommonsChunkPlugin({
    //     name: "init",
    //     minChunks: Infinity
    // }),
    new Webpack.optimize.OccurenceOrderPlugin()
  ],
  postcss: [ autoprefixer({ browsers: ['last 2 versions'] }) ],

  module: {
    loaders: [
      {
        test: /\.html$/,
        exclude: /node_modules/,
        loader: 'file?name=[name].[ext]'
      },
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/, /Stylesheets.elm/],
        loader: 'elm-hot!elm-webpack?verbose=true&warn=true'
      },
      {
        test: /Stylesheets.elm$/,
        loader: 'style!css?sourceMap!postcss!elm-css-webpack'
      }
    ],
    noParse: /^(?!.*Stylesheets).*\.elm$/
  },

  target: 'web',

  devServer: {
    inline: true,
    stats: 'errors-only',
    hot: true,
    progress: true
  }
};
