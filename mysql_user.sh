#!/bin/bash
password_temp=$(grep 'temporary password' /var/log/mysqld.log | awk -F 'localhost:' '{print $2;}')
password=${password_temp:1}
newpassword=$1
expect <<EOF
spawn mysql -uroot -p
expect "password"
send "${password}\n"
expect "mysql>"
#send "set global validate_password_policy=0;\n"
#expect "mysql>"
send "ALTER USER 'root'@'localhost' IDENTIFIED BY \"${newpassword}\";\n"
expect "mysql>"
send "flush privileges;\n"
expect "mysql>"
interact
EOF

