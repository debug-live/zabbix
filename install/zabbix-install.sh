#!/usr/bin/env bash
sed -in "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config
setenforce 0

yum install -y httpd
yum install -y mariadb*

systemctl start mariadb.service
systemctl enable mariadb.service

rpm -i http://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/zabbix-release-3.4-2.el7.noarch.rpm
yum install -y zabbix-server-mysql zabbix-web-mysql zabbix-agent

mysql -uroot <<EOF
create database zabbix character set utf8 collate utf8_bin;
grant all privileges on zabbix.* to zabbix@localhost identified by 'zabbix';
EOF

zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -pzabbix zabbix


sed -in "s/# php_value date.timezone Europe\/Riga/php_value date.timezone Asia\/Shanghai/g" /etc/httpd/conf.d/zabbix.conf

sed -in "s/# DBPassword=/DBPassword=zabbix/g" /etc/zabbix/zabbix_server.conf

sed -in "s/;date.timezone =/date.timezone = Asia\/Shanghai/g" /etc/php.ini

systemctl stop firewalld.service

systemctl restart zabbix-server zabbix-agent httpd
systemctl enable zabbix-server zabbix-agent httpd
