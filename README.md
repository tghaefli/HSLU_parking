# HSLU_parking

## Usage
This small project gets the HSLU parking counter and stores the value in a CSV file. The data will be appended at the end of the file and the file will grow. This is done by remote_data.py with the help of corntab
This CSV file can then be grabbed with sync.sh to a local machine.  
The data can then be evaluated with the file show.m  

  

## Files

| File           | Use       | Location    |
| -------------- | ---------------- | ------------- |
| remote_data.py | Grabs online data and appends it to CSV file with timestamp | Server/Raspberry |
| sync.sh | Grabs CSV from Server/Raspberry and stores it local | local |
| show.m | Plots the CSV data and outputs some values | local |
| show_loop.m | Runs the show.m file in an endless loop | local   |



## Crontab
Open cron with 
```
$ crontab -e
```
then add following line at the end
```
* * * * * /usr/bin/python2.7 /home/pi/logger/script.py
```
