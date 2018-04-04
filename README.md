# viivmall-fe
viivmall-fe

### 项目初始化
[项目初始化详细记录](https://github.com/viivLgr/viivmall/blob/master/README3.md)
- git仓库的建立和项目目录的划分
    1. 新建git项目
    2. git权限配置
    3. gitignore配置
    4. git分支使用规范

- npm使用
    1. npm初始化
    2. 安装、卸载npm包
    3. npm常用机制
    4. npm自定义命令的使用

- webpack
    1. webpack设计思想 一切皆模块
    2. webpack编译原理
    3. webpack的安装
    4. webpack.config.js进化过程

- webpack对脚本的处理
    1. js的loader
    2. js多入口的配置
    3. 目标文件按文件类别分开存放
    4. jquery引入方法
    5. 提取公共模块

- 对样式的处理
    1. css文件使用的loader
    2. css打包成单独的文件

- 对html模板的处理
    1. html-webpack-plugin
    2. 多页应用里html的处理
    3. 通用html模块的抽离

- 对图片和icon-font的处理
    1. 静态资源使用的loader
    2. url-loader里参数的配置

- webpack-dev-server
    1. 安装和配置
    2. 应用场景和使用方法
    3. 环境变量的设置和读取方法
    4. webpack命令和npm自定义命令的结合

- 代码的提交
    1. 代码的提交过程
    2. git的tag用法
  
### 通用工具开发
[通用工具开发详细记录](https://github.com/viivLgr/viivmall/blob/master/README4.md)  
    
#### 通用js工具封装
- 网络请求工具
- URL路径工具
- 模板渲染工具--hogan
- 字段验证 && 通用提示
- 统一跳转


#### 通用UI开发
- 使用font-awesome
- 使用Hogan

#### [接口文档](http://git.oschina.net/imooccode/happymmallwiki/wikis)
#### [学习文档](http://learning.happymmall.com/)

#### 生产环境的适配
- 添加favicon
    ```
    // 获取html-webpack-plugin参数的方法
    var getHtmlConfig = function (name, title) {
        return {
            template: './src/view/' + name + '.html',
            filename: 'view/' + name + '.html',
            favicon: './favicon.ico',
            title: title || '',
            inject: true,
            hash: true,
            chunks: ['common', name]
        }
    }
    ```
- 添加dns-prefetch
    ```
    <link rel="dns-prefetch" href="//cdn.bootcss.com">
    <link rel="dns-prefetch" href="//s.happymmall.com">
    <link rel="dns-prefetch" href="//img.happymmall.com">
    ```
- 线上域名的分离，HTML路径的简化
    ```
    // 解决resource路径问题
    output: {
        path: __dirname + '/dist/',
        publicPath: '/dist/',
        filename: 'js/[name].js'
    },

    // 打包成线上版本的配置
    output: {
        path: __dirname + '/dist/',
        publicPath: 'dev' === WEBPACK_ENV ? '/dist/' : '//s.happymmall.com/mmall-fe/dist/' ,
        filename: 'js/[name].js'
    },
    ```
- 对线上打包结果做回归测试
    1. resource路径问题
    2. hogan对string的压缩打包默认去掉了“”， 在webpack.config.js中添加配置
        ```
        { 
                test: /\.string$/, 
                loader: 'html-loader',
                query: {
                    minimize: true,
                    removeAttributeQuotes: false // 不删除引号
                }
            },
        ```
    3. 注意payment页面接收订单编号参数orderNumber和接口用的参数名要一致

#### SEO
- 概念：SEO是指在了解**搜索引擎自然排名**机制的基础之上，对网站进行内部及外部的调整优化，改进网站在搜索引擎中**关键词**的自然排名，获得更多的展现量，吸引更多目标客户点击访问网站，从而达到互联网营销及品牌建设的目标。
- 衡量标准
    1. 关键词排名
    2. 收录量
- 优化技巧
    1. 增加页面数量
    2. 减少页面层级
    3. 关键词密度
    4. 高质量友链
    5. 分析竞对
    6. SEO数据监控
- 关键词设计
    1. 品牌、slogan：mmall， happymmall, mmall电商
    2. 高频关键词：电商平台，网上购物，网上商城，数码产品，手机，笔记本，相机，手表，耳机
    3. 长尾关键词： 肚子疼怎么办

#### 访问数据统计
- 访问量，PV(页面打开的次数)/UV（访问的总人数）/VV（访问次数）
- 流量来源
- 搜索关键词
- 设备信息
- 百度统计
    账号viivlgr 密码123



### 后台系统技术选型
- 多页应用换成单页应用： 
    1. 不需要SEO
    2. 减少服务器请求压力，静态资源只需要加载一次
    3. 更好的交互体验
- webpack升级 1.x => 2.x  没有兼容性的要求，可以学习新技术
- js => react + es6
- css => sass

- 前后端分离、分层架构、模块化不变




#### 发布上线步骤
- 生产环境配置
    1. 安装nodejs
    2. 安装webpack
    3. 安装ruby && sass（后台管理系统需要）
    4. 安装Git，并配置权限
- 自动化发布脚本的编写
    1. 拉取最新代码
    2. 项目初始化
    3. 执行打包编译
    4. 复制dist目录到目标目录
- nginx和域名配置
    1. Nginx配置域名
    2. 通过指定hosts方式做Nginx配置测试
    3. 更改域名解析
- 域名解析
    1. 备案
    2. 
- 存货监控
    1. 监控主站地址
    2. 监控第三方内容的地址
    3. 脚本异常监控、性能监控、自定义监控
    
