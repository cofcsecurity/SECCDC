#!/usr/bin/python3
import socket
host = input("Enter the host: ")
maxport = int(input("Enter the max port to scan: "))
def portScanner():
    for port in range(1, maxport + 1):
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.settimeout(10)
        result = s.connect_ex((host, port))
        if result == 0:
            print("Port " + str(port) + " is open")
        s.close()
portScanner()
