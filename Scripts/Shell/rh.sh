#!/usr/bin/env bash
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
usermod -aG wheel $(whoami)
yum remove garbagepackage -y
yum install epel-release -y
# echo "Port 22" >> /etc/ssh/sshd_config
# echo "PermitRootLogin no" >> /etc/ssh/sshd_config
# echo "Protocol 2" >> /etc/ssh/sshd_config
# echo "LogLevel VERBOSE" >> /etc/ssh/sshd_config
sudo systemctl reload sshd.service
echo "net.ipv4.conf.all.send_redirects=0" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.send_redirects=0" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.accept_redirects=0" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.accept_redirects=0" >> /etc/sysctl.conf
echo "net.ipv4.icmp.ignore_bogus_error_responses=1" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.accept_source_route=0" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.accept_source_route=0" >> /etc/sysctl.conf
echo "net.ipv4.icmp_echo_ignore_broadcasts=1" >> /etc/sysctl.conf
echo "[+] /etc/sysctl.conf is configured"
echo "alias net-pf-4 off # IPX" >> /etc/modules.conf
echo "alias net-pf-5 off # Appletalk" >> /etc/modules.conf
echo "alias net-pf-10 off # IPv6" >> /etc/modules.conf
echo "alias net-pf-12 off # Decnet" >> /etc/modules.conf 
sudo yum install net-tools nikto.noarch nmap wireshark lynis clamav.x86_64 -y
yum update -y selinux-policy*
#for the email server
adduser pmccabe
adduser dmeeder
adduser rclarke
adduser mwalter
adduser lmcguire
adduser shinson
adduser ctaylor
adduser istapleton

df -h