#!/bin/bash
pkill crond
/usr/sbin/sshd -D &
/usr/sbin/crond

# 修复 mysql 权限问题
if [[ -d /www/server/data ]]; then
    chown -R mysql:mysql /www/server/data
fi

for file in /etc/init.d/*; do
    if [ -x $file ]; then
        $file restart
    fi
done

bt default

tail -f /dev/null