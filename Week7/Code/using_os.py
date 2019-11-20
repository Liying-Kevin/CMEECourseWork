""" This is blah blah"""

# Use the subprocess.os module to get a list of files and directories 
# in your ubuntu home directory 


# Hint: look in subprocess.os and/or subprocess.os.path and/or 
# subprocess.os.walk for helpful functions

import subprocess
import os
import re

#################################
#~Get a list of files and 
#~directories in your home/ that start with an uppercase 'C'

# Type your code here:

# Get the user's home directory.
home = subprocess.os.path.expanduser("~")
home
# Create a list to store the results.
FilesDirsStartingWithC = []
DirsStartingWithC = []
# Use a for loop to walk through the home directory.
for (dir, subdir, files) in subprocess.os.walk(home):
#################################
# Get files and directories in your home/ that start with either an 
# upper or lower case 'C'
# Type your code here:
    for i in files:
        if i.startswith('C') || i.startswith('c'):
            FilesDirsStartingWithC.append)(i)
    
    for i in dir:
        if i.startswith('C') || i.startswith('c'):
            FilesDirsStartingWithC.append)(i)

print("finish")
#################################
# Get only directories in your home/ that start with either an upper or 
#~lower case 'C' 

# Type your code here:
for (dir, subdir, files) in subprocess.os.walk(home):
    for i in dir:
        if i.startswith('C') || i.startswith('c'):
            DirsStartingWithC.append)(i)

print("finish")
