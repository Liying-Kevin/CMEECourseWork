import subprocess
subprocess.Popen("Rscript --verbose TestR.R > ../Result/TestR.Rout 2> ../Result/TestR_errFile.Rout", shell=True).wait()