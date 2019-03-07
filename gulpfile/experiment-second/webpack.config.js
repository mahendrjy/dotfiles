import { scripts as config } from './tasks/config';

module.exports = {
  mode: process.env.NODE_ENV ? 'production' : 'development',
  entry: {
    app: `./${config.srcRoot}/app.js`,
  },
  module: {
    rules: [{ test: /\.js$/, use: 'babel-loader' }],
  },
  output: {
    filename: '[name].js',
  },
  devtool: 'source-map',
};
