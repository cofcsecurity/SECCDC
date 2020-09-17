#!/usr/bin/env bash
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
usermod -aG wheel $(whoami)
yum remove garbagepackage -y
yum install epel-release -y
echo "Port 22" >> /etc/ssh/sshd_config
echo "PermitRootLogin no" >> /etc/ssh/sshd_config
echo "Protocol 2" >> /etc/ssh/sshd_config
echo "LogLevel VERBOSE" >> /etc/ssh/sshd_config
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
yum install fail2ban fail2ban-system -y
yum update -y selinux-policy*
sudo systemctl start fail2ban
sudo systemctl enable fail2ban
echo "[sshd]" >> /etc/fail2ban/jail.d/sshd.local
echo "enabled = true" >> /etc/fail2ban/jail.d/sshd.local
echo "port = 22" >> /etc/fail2ban/jail.d/sshd.local
echo "logpath = /var/log/auth.log" >> /etc/fail2ban/jail.d/sshd.local
echo "maxretry = 3" >> /etc/fail2ban/jail.d/sshd.local
echo "bantime = 86400" >> /etc/fail2ban/jail.d/sshd.local
sudo systemctl restart fail2ban
#for the email server
adduser pmccabe
adduser dmeeder
adduser spappas
adduser mwalter
adduser lmcguire
adduser cmyers
adduser bbillings
adduser nkakadia
