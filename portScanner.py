import socket
ports = []
numports = 0
for i in range(1, 1025):
    ports.append(i)
numhosts = int(input("Enter num hosts: "))
for i in range(numhosts):
    ip = input("Enter ip: ")
for port in ports:
    print('Scanning port #' + str(port))
    socket_obj = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    socket.setdefaulttimeout(1)
    result = socket_obj.connect_ex((ip, port))
    socket_obj.close()
    if result == 0:
        print('Port ' + str(port) + ' is open')
        numPorts += 1
    
    if numPorts == 0:
        print('All ports closed or firewall enabled!')
    numports = 0
