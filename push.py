#python 3


import time
import ftplib


#ftp details
server         = ''
username       = ''
password       = ''
input_name     = 'stats.csv'
output_name    = time.strftime("%Y-%m-%d_%H-%M-%S")+".csv"

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
remote_path = "parking/"
ftp_connection.cwd(remote_path)

#open file
fh = open(input_name, 'rb')

#save file on ftp and close file
ftp_connection.storbinary('STOR '+output_name, fh)
fh.close()
