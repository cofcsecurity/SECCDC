import os
import time

lines = os.popen('sudo service --status-all').readlines()
current = {}

for line in lines:
    sign = line[line.index("[") + 2]
    name = line[line.index("]") + 3:-1]
    current[name] = sign
    print(name + ": " + sign)

while True:
    time.sleep(1)
    lines = os.popen('sudo service --status-all').readlines()

    for line in lines:
        sign = line[line.index("[") + 2]
        name = line[line.index("]") + 3:-1]

        if name not in current.keys():
            print("Service Added! " + name + ":" + sign)
            current[name] = sign
        elif current[name] != sign:
            print("Service Status Changed! " + name + " now " + sign)
            current[name] = sign

    for line in current.keys():
        if line not in lines:
            print("Service Deleted! " + line[line.index("]") + 3:-1])
