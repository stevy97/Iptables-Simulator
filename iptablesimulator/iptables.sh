#!/bin/bash
TCP_SERVICES = "22"
UCP_SERVICES = ""
REMOTE_TCP_SERVICES ="80 443" # web browsing
REMOTE_UDP_SERVICES = "53" #DNS
SSH = "22"

if !(-x /sbin/iptables) #debugging
exit 0
fi

/sbin/iptables -F
/sbin/iptables -X

#Default rules
/sbin/iptables -P INPUT 
/sbin/iptables -P FORWARD 
/sbin/iptables -P OUTPUT ACCEPT

#Accept in/out connexions
/sbin/iptables -t filter -A INPUT -p TCP --dport ${TCP} -j ACCEPT
/sbin/iptables -t filter -A OUTPUT -p TCP --sport ${TCP} -j ACCEPT 

#refuse all over connexions
/sbin/iptables -t filter -A INPUT -j DROP
/sbin/iptables -t filter OUTPUT -j DROP

/sbin/iptables -L
