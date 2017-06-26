#python 3


import time
import ftplib
import configparser



#ftp details
CONFIG_FILE    = 'config.ini'
server         = ''
username       = ''
password       = ''
input_name     = 'stats.csv'
output_name    = time.strftime("%Y-%m-%d_%H-%M")+".csv"

##get ftp server login data
config = configparser.ConfigParser()
config.read(CONFIG_FILE)

try:
	credentials = config['ftp.xeg.ch']			# IMPORTANT, definition
	server = credentials.get('server')
	username = credentials.get('user')
	password = credentials.get('password')
except:
	print("EXCEPTION!!!")

#print "server:    " + server 
#print "user:      " + username
#print "password:  " + password


#Connect to ftp server and login
ftp_connection = ftplib.FTP(server, username, password)

#navigate to folder
remote_path = "parking/raw"
ftp_connection.cwd(remote_path)

#open file and save to ftp (date.csv)
fh = open(input_name, 'rb')
ftp_connection.storbinary('STOR '+output_name, fh)


fh.close()
