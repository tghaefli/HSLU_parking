#python 3

from   datetime import datetime
import urllib
import sys

Filename = 'stats.csv'
url      = 'http://hslu.ximit.ch/parking/?getJSON=true'

print("Program started\n")
d = datetime.now()

# Prepare time for logger
year    = str(d.year)
month   = str(d.month)
day     = str(d.day)
hour    = str(d.hour)
minute  = str(d.minute)
second  = str(d.second)


# Prepare data for logger
page = urllib.urlopen(url)
soup = page.read()

s1, soup, s3 = soup.split('<', 2)
s1, nbr      = soup.split('>', 1)

print(nbr + "\n")

# Log the data
f = open(Filename, 'a')     # a = only append

# year  month   day hour    minute  second  free_slots
f.write(year+"," + month+"," + day+"," + hour+"," + minute+"," + second+",")
f.write(str(nbr))



f.write("\n")
f.flush()
f.close()
print("Program sccessful!")
