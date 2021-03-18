import os
os.system('pwd')
os.system('cwd /var/log/mysql')
inFile = open('mysql.log', 'r')
newdata = []
logins = 0
errors = 0
queries = 0
for line in inFile:
    logdata = line.split('\n')
    newdata.append(logdata[0].split(' '))
    newdata = logdata[0].split()
    for i in range(len(newdata)):
        if newdata[i] == 'Connect':
            print(newdata[4] + ' has logged in')
            logins += 1
        elif newdata[i] == '[ERROR]':
            print('Error in the DataBase:', ' '.join(newdata[5:]))
            errors += 1
        elif newdata[i] == 'Query':
            print('Database Query:', ' '.join(newdata[4:]))
            queries += 1
print("\nStatistics: \nLogins: " + str(logins) + '\nErrors: ' + str(errors) + '\nQueries: ' + str(queries))
