echo -n "Enter your local subnet range and press [ENTER]:"
read internalSubnet

iptables -F
iptables -X
iptables -Z

#Allow Established,related sessions
iptables -I INPUT 1 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -I OUTPUT 1 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -I FORWARD 1 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

#Drop Invalid state packets
iptables -I INPUT 2 -m conntrack --ctstate INVALID -j DROP
iptables -I OUTPUT 2 -m conntrack --ctstate INVALID -j DROP
iptables -I FORWARD 2 -m conntrack --ctstate INVALID -j DROP

#Custom INPUT rules
iptables -A INPUT -s $internalSubnet -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 5001 -j ACCEPT
iptables -A INPUT -p tcp --dport 5000 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p udp --dport 9000:9500 -j ACCEPT
iptables -A INPUT -p udp --dport 5060 -j ACCEPT
iptables -A INPUT -p udp --dport 5090 -j ACCEPT
iptables -A INPUT -p tcp --dport 5432 -j ACCEPT
iptables -A INPUT -p tcp --dport 5482:5485 -j ACCEPT
iptables -A INPUT -p tcp --dport 5488 -j ACCEPT

#Enable Logging
iptables -A INPUT -j LOGNDROP
iptables -A LOGNDROP -p tcp -m limit --limit 5/min -j LOG --log-prefix "Denied TCP: " --log-level 7
iptables -A LOGNDROP -p udp -m limit --limit 5/min -j LOG --log-prefix "Denied UDP: " --log-level 7
iptables -A LOGNDROP -p icmp -m limit --limit 5/min -j LOG --log-prefix "Denied ICMP: " --log-level 7
iptables -A LOGNDROP -j DROP

#Default actions
iptables -P FORWARD DROP
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
