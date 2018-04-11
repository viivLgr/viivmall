## nginx配置和域名解析
1. `cd /usr/loacl/nginx` 进入Nginx目录
2. `cd conf` 进入conf目录
3. `cd vhost/` 进入域名配置
4. `vim happymmall.com.conf` 编辑conf文件
5. `nginx` 查询是否有nginx ，没有则执行
6. `cd .. ` 到nginx目录
7. `cd sbin` 找到Nginx
8. `sudo ./nginx -t` 检查配置文件是否有语法错误
9. `sudo ./nginx -s reload` 重启nginx服务  -s平滑的重启
10. 配置Charles --> tools --> DNS Spoofing  DNS劫持
11. `ifconfig |grep 1` inet addr:172.31.224.184
12. `tail -f access.log` 查看logs