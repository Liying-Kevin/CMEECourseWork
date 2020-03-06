import pandas as pd 


#read data from csv file
data = pd.read_csv("../data/data.csv")
ID = pd.read_csv("../data/ID.csv")
#create some list to store data
rmaxList = []
N0List = []
NmaxList = []
AList = []
TlagList = []
IDList = []

#for loop to find parameter
for j in range(0,ID.shape[0]-1):
    data_subsetID = data[data['ID'] == ID.iat[j,1]]
    currentID = ID.iat[j,1] #selectID
    IDList.append(currentID)
    x = pd.DataFrame(data_subsetID['Time'])
    x = x.sort_index(ascending=False) #Reverse order
    #y = pd.DataFrame(data_subsetID["PopBio"])
    y = pd.DataFrame(data_subsetID["LogPopBio"])
    y = y.sort_index(ascending=False)
    stape = (y.iat[0,0]-y.iat[1,0]/x.iat[0,0]-x.iat[1,0]) #set stape as first stape
    N0 = y.iat[0,0]
    N0List.append(N0)
    Nmax = y.loc[:,"LogPopBio"].max()
    NmaxList.append(Nmax)
    stapeNew = []
    pointList = []
    #for loop to find max stape
    for i in range(1,data_subsetID.shape[0]-1):
        stape2 = (y.iat[i,0]-y.iat[i+1,0])/(x.iat[i,0]-y.iat[i+1,0])
        if stape > stape2:
            stape = stape
        else:
            stape = stape2
        point = (x.iat[i,0],y.iat[i,0])
        stapeNew.append(stape)
        pointList.append(point)

    stapeNew = pd.DataFrame(stapeNew)
    pointList = pd.DataFrame(pointList)
    stapePoint = pd.concat([stapeNew, pointList],axis = 1 )
    stapePoint.columns = ['stape','x','y']
    pointStape = stapePoint[stapePoint['stape'].isin([stape])]
    stape = pointStape.iat[0,0]
    pointX = pointStape.iat[0,1] #find the point
    pointY = pointStape.iat[0,2]
    b = pointY - stape*pointX #calculate the value of b
    Tlag = (N0-b)/stape 
    TlagList.append(Tlag)
    Rmax = stape
    rmaxList.append(Rmax)
    A = Nmax/N0
    AList.append(A)

rmaxList = pd.DataFrame(rmaxList)
N0List = pd.DataFrame(N0List)
NmaxList = pd.DataFrame(NmaxList)
TlagList = pd.DataFrame(TlagList)
IDList1 = pd.DataFrame(IDList)
AList1 = pd.DataFrame(AList)


#output the data to csv file
lISTdATA = pd.concat([IDList1, rmaxList, N0List, NmaxList, TlagList, AList1],axis = 1 )
lISTdATA.columns = ['ID','RMAX','N0','NMAX','TLAG', 'A']

lISTdATA.to_csv('../data/LIST.csv',header=True,index=True)


