# 服务端

- 源配置
    1. 阿里云源配置官网：http://mirrors.aliyun.com
    2. 本教程centos: http://mirrors.aliyun.com/help/centos 已失效
        https://wiki.centos.org/Download
        http://vault.centos.org/6.8/isos/x86_64/
    3. 源配置步骤
        - 备份 
        ```
        sudo mv /etc/yun.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
        ```
        - 下载CentOS-Base.repo到/etc/yum.repos.d/
            本课程使用CentOS 6,下载方式：
            ```
            wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo
            ```

        - 运行yum makecache生成缓存
