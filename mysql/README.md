### mysql

1. `sudo vim /etc/my.conf` 设置conf文件
2. `default-character-set = utf8` 设置编码格式
3. `sudo chkconfig mysqld on` 配置自动启动
4. `sudo chkconfig --list mysqld` 检查2-5是否是启用状态
5. `sudo service mysqld start` 启动service
6. 登录mysql
    ```
    mysql -u root -p // 登录
    select user,host from mysql.user; // 查询用户
    
    flush privileges; // 刷新权限
    ```
7. `sudo vim /etc/sysconfig/iptables` 防火墙开放3306端口
    ```
    #-A INPUT -p tcp -m state --state NEW -m tcp --dport 3306 -j ACCEPT
    ```
8. `sudo service iptables restart` 重启防火墙

9. `insert into mysql.user(Host,User,Password) values("localhost","viivmall",password("viivmall"));` 添加一个用户
10. `create database `mmall` default character set utf8 collate utf8_general_ci;` 创建database
11. `select * from mysql.user \G` 查看用户权限
12. 设置用户权限
```
// 赋予所有权限
grant all privileges on mmall.* to mmall@'%' identified by 'mmall' with grant option; 

// 细化权限设置
grant select,delete,create on mmall.* to mmall@'%' identified by 'mmall' with grant option;

```
grant all privileges on mmall.* to mmall@'%' identified by 'mmall' with grant option;
grant all privileges on mmall.* to mmall@'%' identified by 'mmall' with grant option;