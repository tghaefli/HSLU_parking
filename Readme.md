#Readme of HSLU_parking



## Usage
Run the file 'show.m' in matlab. Done! 





# Insight 

## Hardware required 
1x Raspberry or similar hardware with OS 


## Installation (only required, if you want your own data)
Copy following files to the raspberry: 
- collect.py (collect once per minute data from remote server and stores it in a local csv-file) 
- push_daily.py (pushes the local csv-file to a remote ftp-server once per day) 
- push_minute.py (pushes the local csv-file to a remote ftp-server every minute) 


Add a file called 'credential.txt' which contains following syntax: 
ftp-server:user:password 



Add a crontab job: 
~ crontab -e 
add the follwoing line at the bottom of the file: 
* * * * * python /home/pi/collect.py 
* * * * * python /home/pi/push_minute.py 
1 0 * * * python /home/pi/push_daily.py 



