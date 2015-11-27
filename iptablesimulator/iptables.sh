#!/bin/bash
/sbin/iptables -F
/sbin/iptables -X

#Default rules
/sbin/iptables -P INPUT DROP
/sbin/iptables -P FORWARD DROP
/sbin/iptables -P OUTPUT ACCEPT

#Accept in/out connexions
/sbin/iptables -t filter -A INPUT -p TCP --dport 22 -j ACCEPT
/sbin/iptables -t filter -A OUTPUT -p TCP --sport 22 -j ACCEPT 

#refuse all over connexions
/sbin/iptables -t filter -A INPUT -j DROP
/sbin/iptables -t filter OUTPUT -j DROP

/sbin/iptables -L
