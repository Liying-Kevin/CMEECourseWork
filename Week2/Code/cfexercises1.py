#!/usr/bin/env python3

"""Some functions exemplifying the use of control statements"""
#docstrings are considered part of the running code (normal comments are
#stripped). Hence, you can access your docstrings at run time.
__author__ = 'Liying Huang (liying.huang19@imperial.ac.uk)'
__version__ = '0.0.1'

import sys
#output the number is x** 0.5
def foo_1(x):
    return("result is %d" %(x ** 0.5))

#judge x and y, output the larger number
def foo_2(x, y):
    if x > y:
        return("result is %d" %x)
    return("result is %d" %y)

#sort number from smallest number to largest number
def foo_3(x, y, z):
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    list = [x,y,z]
    return list

#loop from 1 to x+1, ouutput the number
def foo_4(x):
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return("result is %d" %result)

#if x=1, output 1; otherwise output result is other number
def foo_5(x): # a recursive function that calculates the factorial of x
    if x == 1:
        return 1
    x = x * foo_5(x - 1)
    return x


def foo_6(x): # Calculate the factorial of x in a different way
    facto = 1
    while x >= 1:
        facto = facto * x
        x = x - 1
    return("result is %d" %facto)

def main(argv):
    print(foo_1(30))
    print(foo_2(3,6))
    print(foo_3(3,5,6))
    print(foo_4(20))
    print(foo_5(3))
    print(foo_6(40))
    return 0

if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)