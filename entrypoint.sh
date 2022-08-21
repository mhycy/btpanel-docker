#!/bin/bash
pkill crond
/usr/sbin/sshd -D &
/usr/sbin/crond

for file in /etc/init.d/*; do
    if [ -x $file ]; then
        $file restart
    fi
done

bt default

tail -f /dev/null