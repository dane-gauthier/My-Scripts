echo -n "Enter your local subnet range and press [ENTER]:"
read internalSubnet

iptables -F

iptables -A INPUT -s $internalSubnet -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 5001 -j ACCEPT
iptables -A INPUT -p tcp --dport 5000 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p udp --dport 9000:9500 -j ACCEPT

#Default actions
iptables -P FORWARD DROP
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
