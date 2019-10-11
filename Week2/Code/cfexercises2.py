#!/usr/bin/env python3

"""Some functions exemplifying the use of control statements"""
#docstrings are considered part of the running code (normal comments are
#stripped). Hence, you can access your docstrings at run time.
__author__ = 'Liying Huang (liying.huang19@imperial.ac.uk)'
__version__ = '0.0.1'

import sys

def range12(x=12): 
    for j in range(x):
        if j % 3 == 0:
            print("%d can devided by 3" % j)
    return True

def range15(x=15):
    for j in range(x):
        if j % 5 == 3:
            print("%d devided by 5 is 3" % j)
        elif j % 4 == 3:
            print("%d devided by 4 is 3" %j)
    return True

def equal15(z=0):
    z = 0
    while z != 15:
        print("%d is not equal to 15" %z)
        z = z + 3
        print("z is %d" %z)
    return True

def less100(z=12):
    z = 12
    while z < 100:
        if z == 31:
            for k in range(7):
                print("this number is %d." % k)
        elif z == 18:
            print("this number is %d" % z)
        z = z + 1
        print("z is %d" %z)
    return True

def main(argv):
    print(range12(12))
    print(range15(30))
    print(equal15(14))
    print(less100(16))
    return 0

if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)