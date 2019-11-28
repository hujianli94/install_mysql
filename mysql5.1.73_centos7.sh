#!/bin/bash

cd ~/install_mysql
groupadd mysql && useradd -g mysql mysql

tar -zxvf mysql-5.1.73.tar.gz
cd mysql-5.1.73

yum install -y gcc gcc-c++ ncurses* libtermcap* expect

./configure  '--prefix=/usr/local/mysql' '--without-debug' '--with-charset=utf8' '--with-extra-charsets=all' '--enable-assembler' '--with-pthread' '--enable-thread-safe-client' '--with-mysqld-ldflags=-all-static' '--with-client-ldflags=-all-static' '--with-big-tables' '--with-readline' '--with-ssl' '--with-embedded-server' '--enable-local-infile' '--with-plugins=innobase'

make && make install

\cp -rf support-files/my-medium.cnf /etc/my.cnf
\cp -rf support-files/mysql.server /etc/init.d/mysqld
/sbin/chkconfig --del mysqld
/sbin/chkconfig --add mysqld

# 配置权限表
chown -R mysql:mysql /usr/local/mysql
/usr/local/mysql/bin/mysql_install_db --user=mysql


# 启动mysql 给/etc/init.d/mysql 执行权限，然后运行
chmod a+wrx /etc/init.d/mysqld
service mysqld start
sleep 10
export PATH=/usr/local/mysql/bin:$PATH
ln -s /usr/local/mysql/bin/mysql /usr/bin/
# /usr/local/mysql/bin/mysql_secure_installation