#!/bin/bash
# Author: liying huang liying.huang19@imperial.ac.uk
# Script: csvtospace.sh
# Description: substitute the tabs in the files with commas
#
# Saves the output into a .csv file
# Arguments: 1 -> tab delimited file
# Date: Oct 2019

echo "Creating a comma delimited version of $1 ..."
cat $1 | tr -s "," " " >> $1.csv
echo "Done!"
exit
