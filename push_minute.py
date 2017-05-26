#python 3


import ftplib


#ftp details
server         = ''
username       = ''
password       = ''
input_name     = 'stats.csv'

#get ftp server login data
with open('credential.txt') as f:
  credentials = [x.strip().split(':') for x in f.readlines()]

#extract username and password
server,username,password = credentials[0]

#print "server:    " + server 
#print "user:      " + username
#print "password:  " + password


#Connect to ftp server and login
ftp_connection = ftplib.FTP(server, username, password)

#navigate to folder
remote_path = "parking/raw"
ftp_connection.cwd(remote_path)


#open file and save to ftp (stats.csv)
fh = open(input_name, 'rb')
ftp_connection.storbinary('STOR '+input_name, fh)


fh.close()
