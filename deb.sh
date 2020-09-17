#!/usr/bin/env bash
#apt-get sudo and usermod -aG sudo $USER must be run as root
sudo apt-get update
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
sudo apt-get clean
sudo apt-get autoclean
sudo apt-get autoremove
sudo echo "PermitRootLogin no" >> /etc/ssh/sshd_config
sudo echo "Protocol 2" >> /etc/ssh/sshd_config
sudo echo "LogLevel VERBOSE" >> /etc/ssh/sshd_config
sudo systemctl reload sshd.service
sudo echo "net.ipv4.conf.all.send_redirects=0" >> /etc/sysctl.conf
sudo echo "net.ipv4.conf.default.send_redirects=0" >> /etc/sysctl.conf
sudo echo "net.ipv4.conf.all.accept_redirects=0" >> /etc/sysctl.conf
sudo echo "net.ipv4.conf.default.accept_redirects=0" >> /etc/sysctl.conf
sudo echo "net.ipv4.icmp.ignore_bogus_error_responses=1" >> /etc/sysctl.conf
sudo echo "net.ipv4.conf.default.accept_source_route=0" >> /etc/sysctl.conf
sudo echo "net.ipv4.conf.all.accept_source_route=0" >> /etc/sysctl.conf
sudo echo "net.ipv4.icmp_echo_ignore_broadcasts=1" >> /etc/sysctl.conf
sudo echo "[+] /etc/sysctl.conf is configuresd"
sudo echo "alias net-pf-4 off # IPX" >> /etc/modules.conf
sudo echo "alias net-pf-5 off # Appletalk" >> /etc/modules.conf
sudo echo "alias net-pf-10 off # IPv6" >> /etc/modules.conf
sudo echo "alias net-pf-12 off # Decnet" >> /etc/modules.conf 
sudo apt-get install python net-tools nikto.noarch nmap wireshark clamav.x86_64 epel-release -y
sudo apt-get install fail2ban fail2ban-system -y
#This fails for some reason, still working on it
sudo systemctl start fail2ban
sudo systemctl enable fail2ban
sudo echo "[sshd]" >> /etc/fail2ban/jail.d/sshd.local
sudo echo "enabled = true" >> /etc/fail2ban/jail.d/sshd.local
sudo echo "port = 22" >> /etc/fail2ban/jail.d/sshd.local
sudo echo "logpath = /var/log/auth.log" >> /etc/fail2ban/jail.d/sshd.local
sudo echo "maxretry = 3" >> /etc/fail2ban/jail.d/sshd.local
sudo echo "bantime = 86400" >> /etc/fail2ban/jail.d/sshd.local
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
sudo echo "[+] Fail2ban is configures"
wget https://raw.github.com/emposha/Shell-Detector/master/shelldetect.py
python shelldetect.py -r True -d ./
sudo echo "alias shells=\"python shelldetect.py -r True -d ./\"" >> ~/.bashrc
sudo exec bash
git clone https://github.com/CISOfy/lynis
cd lynis; ./lynis audit system >> vulnscan.txt
echo "[+] Lynis scan is done"
echo "Implement firewall rules"