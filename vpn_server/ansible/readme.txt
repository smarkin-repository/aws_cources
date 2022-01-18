http://www.softether-download.com/files/softether/v4.34-9745-rtm-2020.04.05-tree/Linux/SoftEther_VPN_Server/64bit_-_Intel_x64_or_AMD64/

 softether-vpnserver-v4.34-9745-rtm-2020.04.05-linux-x64-64bit.tar.gz

 version="v4.34-9745-rtm-2020.04.05"



wget ${full_url} -o vpnserver.tar.gz

tar xzvf  vpnserver.tar.gz


apt-get install build-essential -y

cd vpnserver

make


mv vpnserver /usr/local
cd /usr/local/vpnserver/


chmod 600 *
chmod 700 vpnserver
chmod 700 vpncmd


vi /etc/init.d/vpnserver


#!/bin/sh
# chkconfig: 2345 99 01
# description: SoftEther VPN Server
DAEMON=/usr/local/vpnserver/vpnserver
LOCK=/var/lock/subsys/vpnserver
test -x $DAEMON || exit 0
case "$1" in
start)
$DAEMON start
touch $LOCK
;;
stop)
$DAEMON stop
rm $LOCK
;;
restart)
$DAEMON stop
sleep 3
$DAEMON start
;;
*)
echo "Usage: $0 {start|stop|restart}"
exit 1
esac
exit 0


mkdir /var/lock/subsys

chmod 755 /etc/init.d/vpnserver && /etc/init.d/vpnserver start
update-rc.d vpnserver defaults