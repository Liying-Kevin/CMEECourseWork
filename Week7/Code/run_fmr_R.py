import subprocess
subprocess.Popen("Rscript --verbose fmr.R > ../Result/fmrR.Rout 2> ../Result/fmrR_errFile.Rout", shell=True).wait()