# viivmall-fe
viivmall-fe

### 项目初始化
![目录结构设计](https://upload-images.jianshu.io/upload_images/5311449-2ec5fd451306526e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
1. git项目建立
    - 使用码云托管私有项目 [地址](https://gitee.com/viivmall/viivmall-fe)
    - 建立组织
    - 新建项目
2. git权限配置
    - `git clone`  选择SSH方式可以不必每次都输入密码，但是要配置**公钥**
    - 生成SSH key的具体步骤
         1. 设置git的username和email
         ```
         $ git config --global user.name "viivLgr"
         $ git config --global user.email "viivLgr@163.com"
         ```
         2. 生成密钥
         ```
         $ ssh-keygen -t rsa -C "viivLgr@163.com"
         ```
         一路回车，输入自己的密码。最后看到两个文件：id_rsa和id_rsa.pub。
         3. 复制`id_rsa.pub`的内容
         ```
         $ cat id_rsa.pub // 查看内容，然后复制
         ```
         4. 在git项目设置中添加密钥
3. .gitignore的配置
    - 生成`.gitignore`文件
    ```
    vim .gitignore // 新建文件

    // 内容
    .DS_Store
    /node_modules/
    /dist/


    :wq   // 保存并退出
    ```
4. 切换分支进行开发
    - 切换新分支
    ```
    $ git checkout -b mmall_v1.0 // -b表示新建  checkout表示切分支 mmall_v1.0表示分支名称
    ```
    - 查看分支
    ```
    $ git branch 
    ```
    - 创建目录文件
    ```
    $ mkdir src       // 新建scr文件夹
    $ cd src          // 进入src文件夹
    $ mkdir view 
    $ mkdir page
    $ mkdir service 
    $ mkdir util
    $ mkdir image
    ```
    - 项目脚手架安装(在项目根目录下)
    ```
    $ npm init        // 初始化，会生成一个package.json文件

    $ sudo npm install webpack@1.15.0 -g   // 管理员权限全局安装1.15.0版本的webpack
    $ npm install webpack@1.15.0 --save-dev  // 在本地目录下安转1.15.0版本的webpack
    ```
    - webpack配置
    ```
    // webpack.config.js
    var config = {
        entry: { // 可以有多个入口文件
            'index': ['./src/page/index/index.js'],
            'login': ['./src/page/login/index.js']
        },
        output: { // 打包目录
            path: './dist',
            filename: 'js/[name].js'
        }
    };
    module.exports = config;
    ```
    引用jQuery CDN https://cdn.bootcss.com/jquery/1.11.3/jquery.min.js  不加协议的情况会自动补全
    修改webpack.config.js，externals可以把外部的模块或变量加载进来
    ```
    externals: {
        jquery': 'window.jQuery'
    }
    ```
    ![externals](https://upload-images.jianshu.io/upload_images/5311449-b67a217e14b9cfc1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
    
    分离公共js
    在webpack.config.js的plugins中加入
    ```
    // 引入webpack
     var webpack = require('webpack');

    // 在entry中配置
    'common': ['./src/page/common/index.js'],

    // 在plugins里配置
    new webpack.optimize.CommonsChunkPlugin({
        name: 'common',
        filename: 'js/base.js'
    }),
    ```

    - webpack css 配置
    ```
    module: {
        loaders: [
            { test: /\.css$/, loader: "style-loader!css-loader"}
        ]
    },
    ```
    webpack分离css单独打包步骤 [参考](https://www.jianshu.com/p/439764e3eff2)
    1. 安装 extract-text-webpack-plugin
    ```
    $ npm install extract-text-webpack-plugin@1.0.1 --save-dev
    ```
    2. 在webpack.config.js里配置
    ```
    // 引入
    var ExtractTextPlugin = require('extract-text-webpack-plugin');

    // 在plugins里配置
    new ExtractTextPlugin("css/[name].css"),
    ```
    3. 修改loader的使用
    ```
    loaders: [
        { test: /\.css$/, loader: ExtractTextPlugin.extract("style-loader", "css-loader")}
    ]
    ```
    - 打包html文件
    1. 安装 html-webpack-plugin 
    ```
    $ npm install html-webpack-plugin --save-dev
    ```
    2. 在webpack.config.js里配置
    ```
    // 引入
    var HtmlWebpackPlugin = require('html-webpack-plugin');

    // 在plugins里配置
    new HtmlWebpackPlugin({
        template: './src/view/index.html',
        filename: 'view/index.html',
        inject: true,
        hash: true,
        chunks: ['common', 'index']
    })
    ```
    3. 批量添加html plugin
    ```
    // 获取html-webpack-plugin参数的方法
    var getHtmlConfig = function(name){
        return {
        template: './src/view/' + name + '.html',
        filename: 'view/' + name + '.html',
        inject: true,
        hash: true,
        chunks: ['common', name]
        }
    }

    // html模板的处理
    new HtmlWebpackPlugin(getHtmlConfig('index')),
    new HtmlWebpackPlugin(getHtmlConfig('login'))
    ```
    4. 创建html模板
    安装html-loader
    ```
    $ npm install html-loader --save-dev
    ```
    新建html-head.html文件
    ```
    <head>
        <meta charset="UTF-8">
    </head>
    ```
    在index.html文件中用require方式引入html-head.html(html-webpack-plugin支持ejs模板写法)
    ```
    <!DOCTYPE html>
    <html lang="en">
    <%= require('html-loader!./layout/html-head.html') %>
    <body>
    <script src="https://cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
    </body>
    </html>
    ```
    - webpack 图片和字体 配置
    1. 安装url-loader 安装file-loader
    ```
    $ npm install url-loader --save-dev
    $ npm install file-loader --save-dev
    ```
    2. webpack.config.js 配置
    limit:限制图片大小 小于limit的图片用base64格式，大于limit的图片保存在resource目录下
    ```
    // loaders: 
    { test: /\.(gif|png|jpg|jpeg|woff|svg|eot|ttf)\??.*$/, loader: 'url-loader?limit=100&name=resource/[name].[ext]'}
    ```

    - 安装webpack-dev-server
    ```
    $ npm install webpacl-dev-server@1.16.5 --save-dev
    ```
    修改webpack.config.js => entry =>  client
    ```
    'common': ['./src/page/common/index.js', 'webpack-dev-server/client?http://loaclhost:8088/'],
    ```
    设置webpack.config.js => output =>  publicPath，解决依赖引用问题
    ```
    publicPath: '/dist',
    ```
    启动
    ```
    $ webpack-dev-server --inline --port 8088
    ```

    - 添加环境变量配置，dev / online
    ```
    var WEBPACK_ENV = process.env.WEBPACK_ENV || 'dev';
    ```
    启动方式
    ```
    // dev 开发启动
    WEBPACK_ENV=dev webpack-dev-server --inline --port 8088
    // online 上线启动
    WEBPACK_ENV=online webpack-dev-server --inline --port 8088
    ```
    修改webpack.config.js配置，根据环境变量决定是否要遭common目录追加webpack-dev-server的client
    ```
    if('dev' === WEBPACK_ENV){
        config.entry.common.push('webpack-dev-server/client?http://loaclhost:8088/');
    }
    ```
    - 将启动命令存放在package.json文件的scripts中，使用npm的短命令
    ```
    "scripts": {
        "dev": "WEBPACK_ENV=dev webpack-dev-server --inline --port 8088",
        "dev_win": "set WEBPACK_ENV=dev && webpack-dev-server --inline --port 8088",
        "dist": "WEBPACK_ENV=dev webpack -p",
        "dist_win": "set WEBPACK_ENV=dev && webpack -p",
    },
    ```

    - 提交
    ```
    $ git status // 查看状态
    $ git add .   // 添加文件
    $ git ca "initial" // 提交文件
    $ git push     // 推送
    $ git push --set-upstream origin mmall_v1.0 // 设置推送分支
    $ git st // 再次查看状态

    $ git merge origin master  // 合并master分支

    $ git tag tag-dev-initail   // 打标签
    $ git push origin tag-dev-initail  // 推送标签
    ```


