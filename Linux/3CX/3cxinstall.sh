wget -O- http://downloads.3cx.com/downloads/3cxpbx/public.key | apt-key add -
echo "deb http://downloads.3cx.com/downloads/3cxpbx/ /" | tee /etc/apt/sources.list.d/3cxpbx.list

apt-get update

apt-get install 3cxpbx

#location of 3cx scripts: /usr/sbin
#location of 3cx system: /var/lib/3cxpbx
