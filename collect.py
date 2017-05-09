#python 3

import urllib
import sys
import time


#crawler webside
Filename = 'stats.csv'
url      = 'http://hslu.ximit.ch/parking/?getJSON=true'



# Prepare data for logger
page = urllib.urlopen(url)
soup = page.read()

s1, soup, s3 = soup.split('<', 2)
s1, nbr      = soup.split('>', 1)


# Log the data
f = open(Filename, 'a')     # a = only append

# year  month   day hour    minute  second  free_slots
f.write(time.strftime("%Y,%m,%d,%H,%M,%S,"))
f.write(str(nbr))


#flush and save and close file
f.write("\n")
f.flush()
f.close()
