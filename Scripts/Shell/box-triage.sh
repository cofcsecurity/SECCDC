#!/bin/bash

# What is the base
cat /etc/*release
uname -a
hostnamectl
uptime

# Who is logged in
who
who -Hu
grep sh$ /etc/passwd

# VM check
dmidecode -s system-manufacturer
dmidecode -s system-product-name
lshw -c system | grep product | head -1
cat /sys/class/dmi/id/product_name
cat /sys/class/dmi/id/sys_vendor

# Hardware chcck
lscpu or cat /proc/cpuinfo
lsmem or cat /proc/meminfo
ifconfig -a
ethtool <devname>
lshw
lspci
dmidecode

# Processes
pstree -pa 1
ps -ef
ps auxf
systemctl

# network check
netstat -tulpn
netstat -anp
lsof -i
ss
iptables -L -n
cat /etc/resolv.conf

# Kernel
uname -r
cat /proc/cmdline
lsmod
sysctl -a
cat /boot/grub2/grub.cfg

# Logs 
dmesg
tail -f /var/log/messages
journalctl