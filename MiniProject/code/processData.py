import pandas as pd 
import seaborn as sns
import math


#read data from csv file
data = pd.read_csv("../data/LogisticGrowthData.csv")
pd.read_csv("../data/LogisticGrowthMetaData.csv")
#insert unique ID 
data.insert(0, "ID", data.Species + "_" + data.Temp.map(str) + "_" + data.Medium + "_" + data.Citation + "_" + data.Rep.map(str))
#print(data.ID.unique())
ID = pd.DataFrame(data.ID.unique())
ID.shape[0] # ID ROWS 
#create dataframe to store data and id
IDDataList=pd.DataFrame()
allDataList=pd.DataFrame()

#for loop to select data 
for i in range(0,ID.shape[0]-1):
    data_subset = pd.DataFrame(data[data['ID']==ID.iat[i,0]])
    #sns.lmplot("Time", "PopBio", data = data_subset, fit_reg = False)
    if data_subset.shape[0] > 5:
        IDData = pd.DataFrame(data_subset.ID.unique())
        allData = pd.DataFrame(data_subset)
        IDDataList = pd.concat([IDDataList,IDData],ignore_index = True)
        allDataList = pd.concat([allDataList,allData],ignore_index = True)

#delete some data that no meaning
allDataList=allDataList[allDataList['PopBio']>0]
allDataList=allDataList[allDataList['Time']>=0]

#get log(n)
PopBio = pd.DataFrame(allDataList["PopBio"])
LogPopBioList = []
for i in range(0,PopBio.shape[0]-1):
    LogPopBio = math.log(PopBio.iat[i,0])
    LogPopBioList.append(LogPopBio)
LogPopBioList =  pd.DataFrame(LogPopBioList) 
allDataList.insert(allDataList.shape[1], "LogPopBio", LogPopBioList)
#output date to csv.file
allDataList.to_csv('../data/data.csv',header=True,index=True)         
IDDataList.to_csv('../data/ID.csv',header=True,index=True)



