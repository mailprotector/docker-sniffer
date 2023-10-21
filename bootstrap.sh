#!/bin/bash
set -m

LICENSE=$(env | grep "LICENSE" | awk -F "=" '{print $2}')
AUTH=$(env | grep "AUTH" | awk -F "=" '{print $2}')

cp /usr/sbin/getRulebase /tmp/getRulebase

echo "bootstrap: setting sniffer license - $LICENSE"
sed -i "s|licenseid|$LICENSE|g" "/tmp/getRulebase"

echo "bootstrap: setting sniffer authentication - $AUTH"
sed -i "s|authenticationxx|$AUTH|g" "/tmp/getRulebase"

echo "bootstrap: creating identity.xml"
echo "<snf><identity licenseid=\"$LICENSE\" authentication=\"$AUTH\"/></snf>" > /etc/snf-server/identity.xml

cp /tmp/getRulebase /usr/sbin/getRulebase

echo "bootstrap: downloading rulebase"
/usr/sbin/getRulebase

touch "/var/log/snf-server/$LICENSE.log"

# snf server
echo "bootstrap: starting snfserver"
/usr/sbin/SNFServer /etc/snf-server/SNFServer.xml &

# recognize PIDs
pidlist=$(jobs -p)

# initialize latest result var
latest_exit=0

# define shutdown helper
function shutdown() {
    trap "" SIGINT

    for single in $pidlist; do
        if ! kill -0 "$single" 2> /dev/null; then
            wait "$single"
            latest_exit=$?
        fi
    done

    kill "$pidlist" 2> /dev/null
}

# run shutdown
trap shutdown SIGINT
wait -n

# return received result
exit $latest_exit
