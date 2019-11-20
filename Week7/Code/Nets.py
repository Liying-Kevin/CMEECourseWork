import networkx as nx
import scipy as sc
import matplotlib.pyplot as p
import pandas as pd
import numpy as np


f1 = pd.read_csv('../Data/QMEE_Net_Mat_edges.csv', sep=',')
f2 = pd.read_csv('../Data/QMEE_Net_Mat_nodes.csv')


f1.index=['ICL','UoR','CEH','ZSL','CEFAS','NonAc']
f1Data = pd.DataFrame(f1)

index = pd.DataFrame(f1Data.index[np.where(f1Data!=0)[0]])
col = pd.DataFrame(f1Data.columns[np.where(f1Data!=0)[1]])
Lnk = [0,1]
ALst = []
index[0][0]
col[0][17]

for i in range(18):
    Lnk[0] = index[0][i]
    Lnk[1] = col[0][i]
    print(i)
    print(Lnk)
    ALst.append(Lnk)
    print(ALst)

print(ALst)







