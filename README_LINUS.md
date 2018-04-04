# linux

> 改过bash_profile这个文件,最后不知怎么的只有cd命令能执行,执行`export PATH=/usr/bin:/usr/sbin:/bin:/sbin:/usr/X11R6/bin `就好了~

### 基本
`-rw-r--r--` ---> 6 4 4
1. 类型
    - ‘-’：文件
    - ‘d’: 目录
    - ‘l’: 软连接文件
2. 所属用户
    - ‘rw-’:u所有者
    - ‘r--’:g所属组
    - ‘r--’:o其他人
3. 操作
    - ‘r’: 读 ---> 4
    - ‘w’: 写 ---> 2
    - ‘x’: 执行 --- > 1
## 修改
- `chmod` [选项] 模式名 文件名
    1. 选项
        -R 递归
    2. 模式
        [ugoa][+-=][rwx]
        [mode=421]
- `chmod u+x file.js` ：给管理者(u)执行(x)file.js的权限
- `chmod g+w,o+w file.js`: 给组内（g）和其他人（o）写（w）的权限
- `chmod g-w,o-w file.js`: 减组内（g）和其他人（o）写（w）的权限
- `chmod g=rwx file.js`: 给组内（g）读写执行（rwx）的权限
- `chmod a=rwx file.js`: 给所有人读写执行（rwx）的权限

### 用户
- 更换系统之后
    `mv .ssh/known_hosts .ssh/known_hosts_old` 删掉原来的旧密码
- 添加用户
    `useradd -d /usr/viiv -m viiv` -d 和-m 为viiv创建目录 /usr/viiv
    `cd /usr/viiv/`
    `passwd viiv` 给viiv设置密码
- 删除用户
    `userdel viiv` 删除viiv用户
- 赋予普通用户sudo权限
    - `sudo vim /etc/sudoers`
    - `/root` 找到root
    - `:noh` 取消高亮
    - `viiv  ALL=(ALL)   ALL` 保持和root一致
    - `:wq!` 强制保存退出
    - `exit` 退出使用viiv登录
    - `ssh viiv@47.104.161.190` 重新连接服务器

- 下载安装
    1. 准备目录
    - `cd /` 进去根目录
    - `sudo mkdir developer` 创建文件夹
    - `cd developer` 进入文件夹
    2. 下载jdk
    - `sudo wget http://learning.happymmall.com/jdk/jdk-7u80-linux-x64.rpm` 下载jdk
    - `sudo chmod 777 jdk-7u80-linux-x64.rpm` 设置777权限
    - `sudo rpm -ivh jdk-7u80-linux-x64.rpm` 安装
    - `cd /usr/java/jdk1.7.0_80/` /usr/java目录下有jdk
    - `sudo vim /etc/profile`  设置环境变量
    ```
    export JAVA_HOME=/usr/java/jdk1.7.0_80
    export CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
    export MAVEN_HOME=/developer/apache-maven-3.0.5
    export NODE_HOME=/usr/local/node-v4.4.7-linux-x64
    export RUBY_HOME=/usr/local/ruby
    export CATALINA_HOME=/developer/apache-tomcat-7.0.73

    export PATH=$PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin:$MAVEN_HOME/bin:$NODE_HOME/bin:/usr/local/bin:$RUBY_HOME/bin


    export LC_ALL=en_US.UTF-8
    ```
    - `source /etc/profile` 使配置生效
    - `java -version` 可以看到Java安装成功
    3. 下载Tomcat
    - `sudo wget http://learning.happymmall.com/tomcat/apache-tomcat-7.0.73.tar.gz` Tomcat
    - `sudo tar -zxvf apache-tomcat-7.0.73.tar.gz` 解压
    - `sudo mv apache-tomcat-7.0.73.tar.gz  setup/` 将安装文件移动到setup
    - `cd apache-tomcat-7.0.73/` 进入Tomcat
    - `sudo vim conf/server.xml` 编辑server.xml文件 `URIEncoding="utf-8"`
    - `cd bin` 进入bin目录
    - `sudo ./startup.sh` 运行startup.sh
    4. 下载maven
    - `sudo wget http://learning.happymmall.com/maven/apache-maven-3.0.5-bin.tar.gz`
    - `sudo tar -zxvf apache-maven-3.0.5-bin.tar.gz` 解压
    - `sudo mv apache-maven-3.0.5-bin.tar.gz  setup/` 将安装文件移动到setup
    - `mvn -version` 查看maven版本信息
    5. vsftpd
    - `sudo yum -y install vsftpd` -y表示自动y
    - `cd /` 进入根目录
    - `sudo mkdir product` 创建文件夹product代表线上环境
    - `cd product`
    - `sudo mkdir ftpfile`
    - `sudo useradd ftpuser -d /product/ftpfile/ -s /sbin/nologin` 创建用户
    - `sudo chown -R ftpuser.ftpuser ./ftpfile/` 修改用户和用户组，赋予权限
    - `sudo passwd ftpuser` 重置ftpuser的密码  123456
    - `cd /etc/vsftpd/`
    - `sudo vim chroot_list` 填写`ftpuser` 保存退出
    - `sudo vim /etc/selinux/config` 修改安全策略 看到是disabled就可以退出
    - `sudo setsebool -P ftp_home_dir 1` setsebool:  SELinux is disabled. 和直接修改config是一样的
    - `sudo mv vsftpd.conf vsftpd.conf.bak` 将conf文件备份
    - `sudo wget http://learning.happymmall.com/vsftpdconfig/vsftpd.conf` 下载conf文件
    6. nginx
    - `sudo wget http://learning.happymmall.com/nginx/linux-nginx-1.10.2.tar.gz`
    - `sudo yum install gcc` 安装依赖
    - `sudo yum -y install gcc zlib zlib-devel pcre-devel openssl openssl-devel` nginx安装依赖命令  批量！！！
    - `sudo tar -zxvf linux-nginx-1.10.2.tar.gz` 解压
    - `cd nginx-1.10.2/`
    - `sudo ./configure` 执行configure命令开始编译解压
    - `sudo make` 处理.c扩展名的文件
    - `sudo make install` 
    - `whereis nginx` nginx: /usr/local/nginx
    - `cd /usr/local/nginx/`
    - `cd conf/`
    - `sudo vim nginx.conf` 编辑主文件   include vhost/*.conf; 放在https上面
    - `sudo mkdir vhost` 创建vhost文件夹 添加反向代理的配置文件
    - `sudo wget http://learning.happymmall.com/nginx/linux_conf/vhost/admin.happymmall.com.conf`
    - `sudo wget http://learning.happymmall.com/nginx/linux_conf/vhost/happymmall.com.conf`
    - `sudo wget http://learning.happymmall.com/nginx/linux_conf/vhost/img.happymmall.com.conf`
    - `sudo wget http://learning.happymmall.com/nginx/linux_conf/vhost/s.happymmall.com.conf`
    - `cd ..`
    - `cd ..`
    - `cd conf/`
    - `sudo vim nginx.conf`  :set number 显示行号 修改没有加分号的include vhost/*.conf;
    - `cd sbin/`
    - `sudo ./nginx`
    7. mysql
    - `sudo rpm -qa | grep mysql-server` 查看mysql
    - `sudo yum -y install mysql-server` 安装mysql 
    - `sudo vim /etc/my.cnf` 编辑my.cnf 
        ```
        character-set-server=utf8
        default-character-set=utf8
        ```
    - `sudo chkconfig mysqld on`
    - `sudo chkconfig --list mysqld` 查看   mysqld	0:off	1:off	2:on	3:on	4:on	5:on	6:off
    - `sudo service mysqld restart` 重启mysqld
    - `mysql -u root` 登录mysql
    - `select user,host,password from mysql.user` 回车 ; 查看表中  
    ![mysql](https://upload-images.jianshu.io/upload_images/5311449-71d3dc59a7e28d48.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
    - `set password for root@localhost = password('rootpassword');` 设置密码
    - `set password for root@izm5e4vtdec3c7q9jf19q9z = password('rootpassword');`
    - `set password for root@127.0.0.1 = password('rootpassword');`
    - `exit` 退出
    - `mysql -u root -p` 带密码方式登录 ，需要输入密码
    - `delete from mysql.user where user='';` 删掉表中匿名用户
    - `flush privileges;` 刷新
    - `insert into mysql.user(host,user,password) values ("localhost","viivmall",password("viivpassword"));` 插入用户
    - `create database `viivmall` default character set utf8 COLLATE utf8_general_ci;` 创建database
    - `show databases;` 查看database
    - `flush privileges;` 刷新
    - `grant all privileges on viivmall.* to viivmall@localhost identified by 'viivpassword';` 将viivmall用户赋予viivmall的database的host权限
    - `exit` 退出
    - `cd /developer/`
    - `sudo wget http://learning.happymmall.com/mmall.sql` 下载sql文件 路径 /developer
    - `mysql -u root -p` 登录mysql
    - `show databases;` 查看databases
    - `use viivmall;` change database
    - `show tables;` 查看表 此时为空
    - `source /developer/mmall.sql` 创建表
    - `select * from mmall_user\G` \G 表示格式化  查看表
    8. git
    - `cd /developer/setup`
    - `sudo wget http://learning.happymmall.com/git/git-v2.8.0.tar.gz` 下载Git
    - `sudo yum -y install zlib-devel openssl-devel cpio expat-devel gettext-devel curl-devel perl-ExtUtils-CBuilder perl-ExtUtils- MakeMaker ` 安装git依赖
    - `sudo tar -zxvf git-v2.8.0.tar.gz` 解压
    - `sudo make prefix=/usr/local/git all`
    - `sudo make prefix=/usr/local/git install`
    - `sudo vim /etc/profile` 进入配置path 放在Java后面
    ```
    export PATH=$PATH:$JAVA_HOME/bin:/usr/local/git/bin:$CATALINA_HOME/bin:$MAVEN_HOME/bin:$NODE_HOME/bin:/usr/local/bin:$RUBY_HOME/bin
    ```
    - `source /etc/profile` 使之生效
    - `git --version` 查看版本号
    - `git config --global user.name "viiv"`  配置用户名
    - `git config --global user.email "viiv_lgr@163.com"` 配置用户邮箱
    - `git config --global core.autocrlf false` 设置忽略Windows和mac不同电脑换行符转换
    - `git config --global core.quotepath off` 配置编码 避免中文乱码
    - `git config --global gui.encoding utf-8` 配置gui
    - `ssh-keygen -t rsa -C "viiv_lgr@163.com"`
    - `ssh-add ~/.ssh/id_rsa` Could not open a connection to your authentication agent.
    - `eval `ssh-agent`   `      Agent pid 15607
    - `ssh-add ~/.ssh/id_rsa`   Identity added: /usr/viiv/.ssh/id_rsa (/usr/viiv/.ssh/id_rsa)
    - `cat ~/.ssh/id_rsa.pub` 看一下刚加的公钥 去码云上修改资料公钥
    ```
    ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAu3ZCl2tTXxW8sCiOXawmXE7qUpvesrJOvHmnJtMpXUEdU3Aa6pC/4uBj0nQapiq2oFfeh1EsD5l8/BnHOtXfxk99yVQb8xvCC3k1uEE6PJFdu0Z4XbZQlgmmJ+pdRGusNwb3tOs0WdKuI3wnRD29TypEb1FALG1/fXX4YJjBAEMeoWSeL0GAcqN73d4wZJ8A+BfcA58c/csNnPl+JnYQB0gk4twagzfHg36AuTNaO8vx3m4/ZYqgAdtYQf24UJ2GHkBHqR0KJ0oSY+OnDuQ32SZFuIWgcaboU2Xm4OKLPgzEf/w0Chs95h0M8O57PBFt/7sC8py0guFA7DEsceUEUw== viiv_lgr@163.com
    ```
    9. 防火墙
    - `cd  /etc/sysconfig`
    - `ll |grep ipt` 查看有没有iptables
    - `sudo iptables -P OUTPUT ACCEPT` 初始化防火墙,将输出设置为accept
    - `sudo service iptables save` 保存
    - `ll |grep ipt` 查看已经有iptables了
    - `sudo mv iptables iptables.bak` 备份
    - `sudo wget http://learning.happymmall.com/env/iptables` 下载
    - `sudo vim iptables` 编辑
    - 将3306 5005 8080 端口号都关掉 ，保存退出
    - `sudo service iptables restart` 重启iptables
    10. 自动化发布
    - `cd /developer/`
    - `sudo wget http://learning.happymmall.com/deploy/deploy.sh` 下载
    - `sudo vim deploy.sh` 编辑查看自动化发布脚本
    - `sudo mkdir git-repository`
    - `cd git-repository/` 
    - `cd /` 
    - `sudo chown -R viiv /developer/` 给viiv  developer文件夹权限
    - `sudo chmod u+w -R /developer/` 给拥有者写权限
    - `sudo chmod u+r -R /developer/` 给拥有者读权限
    - `sudo chmod u+x -R /developer/` 给拥有者执行权限
    - `cd /developer/git-repository/` 进入git目录
    - `git clone git@gitee.com:viivmall/viivmall-fe.git` 克隆代码












    

