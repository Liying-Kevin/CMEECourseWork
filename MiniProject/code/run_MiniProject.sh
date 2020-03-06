#!/bin/bash


echo "run python file"
cd MiniProject/code
python3 processData.py
python3 startingPoint.py

echo "run r file"
source("modelFitting.R")

echo "run LATEX file"
bash CompileLaTeX.sh Report

echo "finish"
