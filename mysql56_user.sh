#!/bin/bash
newpassword=$1
expect <<EOF
spawn mysql -uroot -p
expect "password"
send "\n"
expect "mysql>"
send "update mysql.user set password=password('${newpassword}') where user='root';\n"
expect "mysql>"
send "flush privileges;\n"
expect "mysql>"
interact
EOF

