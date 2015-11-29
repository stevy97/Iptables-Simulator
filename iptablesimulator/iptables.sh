#!/bin/bash
case $1 in
start)
        iptables -P INPUT ACCEPT
        iptables -P FORWARD ACCEPT
        iptables -P OUTPUT ACCEPT

        iptables -N DEBUT
        iptables -N G1
        iptables -N G2
        iptables -N G3
        iptables -N G4
        iptables -N FIN

        iptables -A INPUT -m conntrack --cstate ESTABLISHED, RELATED -j ACCEPT
        iptables -A INPUT -j DEBUT

        iptables -A G1 -p tcp --dport 1111 -m recent --name ETAT1 --set -j DROP
        iptables -A G1 -j DROP

        iptables -A G2 -m recent --name ETAT1 --remove
        iptables -A G2 -p tcp --dport 2222 -m recent --name ETAT2 --set -j DROP
        iptables -A G2 -j G1

        iptables -A G3 -m recent --name ETAT2 --remove
        iptables -A G3 -p tcp --dport 3333 -m recent --name ETAT3 --set -j DROP
        iptables -A G3 -j DROP

        iptables -A G4 -m recent --name ETAT3 --remove
        iptables -A G4 -p tcp --dport 4444 -m recent --name ETAT4 --set -j DROP
        iptables -A G4 -j DROP

        iptables -A FIN -m recent --name ETAT4 --remove
        iptables -A FIN -p tcp --dport 22 -j ACCEPT
        iptables -A FIN -j G1

        iptables -A DEBUT -m recent --rcheck --name ETAT4 -j FIN
        iptables -A DEBUT -m recent --rcheck --name ETAT3 -j G4
        iptables -A DEBUT -m recent --rcheck --name ETAT2 -j G3
        iptables -A DEBUT -m recent --rcheck --name ETAT1 -j G2
        iptables -A DEBUT -j G1
;;

stop)
        iptables -F
        iptables -X
;;
esac

        iptables -L
