# 通用js工具封装

- 网络请求工具
```
// 网络请求
request: function (param) {
    var _this = this;
    $.ajax({
        type: param.method || 'GET',
        url: param.url || '',
        dataType: param.type || 'json',
        data: param.data || '',
        success: function (res) {
            if (0 === res.status) {
                typeof param.success === 'function' && param.success(res.data, res.msg);
            } else if (10 === res.status) {
                // 没有登录状态，需要强制登录
                _this.doLogin();
            } else if (1 === res.status) {
                // 请求数据错误
                typeof param.error === 'function' && param.error(res.msg);
            }
        },
        error: function (err) {
            typeof param.error === 'function' && param.error(err.statusText);
        }
    })
},
// 获取服务器地址
getServerUrl: function (path) {
  return conf.serverHost + path;
},

```
- URL路径工具
```javascript
// 获取url参数
getUrlParam: function (name) {
    var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)');
    var result = window.location.search.substr(1).match(reg);
    return result ? decodeURIComponent(result[2]) : null;
},
```
- 模板渲染工具--hogan
```
$ npm install hogan --save
```
```javascript
var Hogan = require('hogan');

// 渲染html模板
renderHtml: function (htmlTemplate, data) {
    var template = Hogan.compile(htmlTemplate),
        result = template.render(data);
    return result;
},
```
- 字段验证 && 通用提示
```javascript
// 字段验证，支持非空、手机、邮箱的判断
validate: function(value, type){
    var value = $.trim(value);
    // 非空验证
    if('require' === type){
        return !!value;
    }
    // 手机号
    if('phone' === type){
        return /^1\d{10}$/.test(value);
    }
    // 邮箱格式验证
    if('email' === type){
        return /^(\w)+(\.\w+)*@(\w)+((\.\w{2,3}){1,3})$/.test(value);
    }
},
```
- 统一跳转
```javascript
// 统一登录处理
doLogin: function () {
    window.location.href = './login.html?redirect=' + encodeURIComponent(window.location.href);
},
goHome: function(){
    window.location.href = './index.html';
}
```

## 通用UI开发
- 使用font-awesome
    1. 安装
    ```
    $ npm install font-awesome --save
    ```
    2. 设置路径
    ```javascript
    // webpack.config.js 配置路径
    node_modules: __dirname + '/node_modules',
  
    // common/index.js 整体引用
    require('node_modules/font-awesome/css/font-awesome.min.css');
    ```
    3. html 中使用
    ```html
    <i class="fa fa-user"></i>
    ```
- 使用Hogan
    1. 安装
    ```
    $ npm install hogin --save
    ```
    2. 引入
    ```javascript
    var Hogan = require('hogan');

    // 添加util工具类
    // 渲染html模板
    renderHtml: function (htmlTemplate, data) {
        var template = Hogan.compile(htmlTemplate),
            result = template.render(data);
        return result;
    }
    ```
    3. webpack.config.js的loader配置
    ```javascript
    { test: /\.string$/, loader: 'html-loader' }
    ```
    
    4. 使用模板 index.string文件
    ```html
    {{#navList}}
    {{#isActive}}
    <li class="nav-item active">
    {{/isActive}}
    {{^isActive}}
    <li class="nav-item">
    {{/isActive}}
        <a href="{{href}}" class="link">{{desc}}</a>
    </li>
    {{/navList}}
    ```
    ```javascript
    var _uitl = require('util/util.js');
    var templateIndex = require('./index.string');
    // 渲染list数据
    var navHtml = _uitl.renderHtml(templateIndex, {
        navList: this.option.navList
    });
    ```
    
- 页面title使用htmlWebpackPlugin设置

    1. webpack.config.js
    ```javascript
    // 获取html-webpack-plugin参数的方法
    var getHtmlConfig = function (name, title) {
        return {
            template: './src/view/' + name + '.html',
            filename: 'view/' + name + '.html',
            title: title || '',
            inject: true,
            hash: true,
            chunks: ['common', name]
        }
    }
  
    // html模板的处理
    new HtmlWebpackPlugin(getHtmlConfig('index', '首页')),
    ```
    2. 页面引用
    ```html
    <title><%= htmlWebpackPlugin.options.title%> -- viivmall电商平台</title>
    ```