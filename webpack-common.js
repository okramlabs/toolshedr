'use strict';

const path = require('path')
const Webpack = require('webpack')
const HtmlWebpackPlugin = require('html-webpack-plugin')

/**
 *
 * @param options
 * @returns {{devtool: *, entry: string[], output: {path: (string|*), filename: string}, plugins: *[], module: {loaders: *[]}}}
 */
module.exports = (options) => {

    let webpackConfig = {
        devtool: options.devtool,
        entry: [
            `webpack-dev-server/client?http://localhost:${options.port}`,
            'webpack/hot/dev-server',
            './src/app/js/index'
        ],
        output: {
            path: path.join(__dirname, 'dist'),
            filename: 'toolshedr.js'
        },
        plugins: [
            new Webpack.DefinePlugin({
                'process.env': {
                    NODE_ENV: JSON.stringify(options.isProduction ? 'production' : 'development')
                }
            }),
            new HtmlWebpackPlugin({
                template: './src/app/index.html'
            }),
            new Webpack.DefinePlugin({
                TOOLSHEDR_VERSION: JSON.stringify(require('./package.json').version)
            })
        ],
        module: {
            loaders: [{
                test: /\.js$/,
                exclude: /(node_modules)/,
                loader: 'babel',
                query: {
                    presets: ['es2015']
                }
            }]
        }
    };

    if (options.isProduction) {
        webpackConfig.entry = ['./src/scripts/index'];

        webpackConfig.plugins.push(
            new Webpack.optimize.OccurenceOrderPlugin(),
            new Webpack.optimize.UglifyJsPlugin({
                compressor: {
                    warnings: false
                }
            }),
            ExtractSASS
        );

        webpackConfig.module.loaders.push({
            test: /\.scss$/i,
            loader: "style!css!sass?outputStyle=expanded&includePaths[]=" + path.resolve(__dirname, "./node_modules/compass-mixins/lib")
        });

    } else {
        webpackConfig.plugins.push(
            new Webpack.HotModuleReplacementPlugin()
        );

        webpackConfig.module.loaders.push({
            test: /\.scss$/i,
            loader: "style!css!sass?outputStyle=expanded&includePaths[]=" + path.resolve(__dirname, "./node_modules/compass-mixins/lib")
        }, {
            test: /\.js$/,
            loader: 'eslint',
            exclude: /node_modules/
        });

        webpackConfig.devServer = {
            contentBase: './dist',
            hot: true,
            port: options.port,
            inline: true,
            progress: true
        };
    }

    return webpackConfig;
}