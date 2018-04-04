# 上线流程
- 登录阿里云服务器
    1. 登录
    ```
    ssh root@47.104.161.190
    输入密码
    // 新建用户
    useradd -d /usr/viiv -m viiv
    cd /usr/viiv 
    passwd viiv // 设置密码
    ```

    2. 设置快捷登录方式
    - `vim .bash_profile`命令进入.bash_profile文件
    - 输入 `alias goviiv='ssh viiv@47.104.161.190'` 添加快捷命令 
    - 保存退出 `:wq`
    - 使用短命令登录 `goviiv`,提示输入密码登录
     ![短命令登录](https://upload-images.jianshu.io/upload_images/5311449-c5e2ad4791375f18.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
    - `ifconfig` 查看服务器信息
    - `ifconfig | grep 172` 查看地址
    ![ifconfig | grep 172](https://upload-images.jianshu.io/upload_images/5311449-e3e34fb84844745e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
    

- 生产环境配置
    1. 安装nodejs
    ```
    // 下载
    wget https://nodejs.org/download/release/v4.4.7/node-v4.4.7-linux-x64.tar.gz
    ```
    ![下载nodejs](https://upload-images.jianshu.io/upload_images/5311449-44263b00bedb3321.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
    ```
    // 解压缩 x:解压  z:gz格式的文件 v:看到解压过程 f:文件名
    tar -xzvf node-v4.4.7-linux-x64.tar.gz
    ```
    ![nodejs解压成功并查看](https://upload-images.jianshu.io/upload_images/5311449-48f7ecf54f731c9d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
    ```
    // 将node移动到/usr/local
    cd /user/local 
    mv ~/node-v4.4.7-linux-x64 ./
    ls  //查看
    ```
    ![移动nodejs到local](https://upload-images.jianshu.io/upload_images/5311449-b2419f1d277b2889.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
    ```
    // 配置环境变量
    vim /etc/profile
    
    export NODE_HOME=/usr/local/node-v4.4.7-linux-x64
    
    export PATH=$NODE_HOME/bin

    // 退出
    // 重新source
    source /etc/profile

    // 查看版本号
    node -v
    ```
    ![node -v](https://upload-images.jianshu.io/upload_images/5311449-838d82ddbff7715b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
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